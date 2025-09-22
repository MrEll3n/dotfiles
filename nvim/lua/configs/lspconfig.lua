local M = {}

function M.setup()
  -- NvChad defaulty (on_attach, capabilities, ...)
  local nvlsp = require("nvchad.configs.lspconfig")
  nvlsp.defaults()

  local lspconfig = require("lspconfig")

  -- Servery, které chceš vždy (klidně uprav)
  local baseline = { "html", "cssls" }

  -- Načti per-server volby z ~/.config/nvim/lua/configs/lsp/*.lua
  local opts_by_server = {}
  local lsp_dir = vim.fn.stdpath("config") .. "/lua/configs/lsp"
  local ok_list, files = pcall(vim.fn.readdir, lsp_dir, [[v:val =~ '\.lua$']])
  if ok_list then
    for _, file in ipairs(files) do
      local name = file:gsub("%.lua$", "")
      local ok, mod = pcall(require, "configs.lsp." .. name)
      if ok then
        opts_by_server[name] = mod
      else
        vim.notify("LSP opts load failed for " .. name .. ": " .. tostring(mod), vim.log.levels.WARN)
      end
    end
  end

  -- sjednoť baseline + dynamické moduly
  local all_servers = vim.deepcopy(baseline)
  for name, _ in pairs(opts_by_server) do
    if not vim.tbl_contains(all_servers, name) then
      table.insert(all_servers, name)
    end
  end

  -- merge s NvChad defaulty
  local function merge_opts(user_opts)
    local opts = user_opts or {}
    if opts.on_attach then
      local user_on_attach = opts.on_attach
      opts.on_attach = function(client, bufnr)
        nvlsp.on_attach(client, bufnr)
        user_on_attach(client, bufnr)
      end
    else
      opts.on_attach = nvlsp.on_attach
    end
    opts.capabilities = vim.tbl_deep_extend("force", {}, nvlsp.capabilities or {}, opts.capabilities or {})
    return opts
  end

  local function setup_server(server)
    if not lspconfig[server] then
      vim.notify("lspconfig: unknown server '" .. server .. "'", vim.log.levels.WARN)
      return
    end
    local mod = opts_by_server[server]
    local opts = {}
    if type(mod) == "function" then
      local ok, produced = pcall(mod, nvlsp) -- modul může vracet opts funkčně
      opts = ok and (produced or {}) or {}
    elseif type(mod) == "table" then
      opts = mod
    end
    lspconfig[server].setup(merge_opts(opts))
  end

  -- Mason už máš → jen použij mason-lspconfig pro ensure_installed (pokud je)
  local ok_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
  if ok_mason_lsp then
    mason_lsp.setup {
      ensure_installed = all_servers,
      automatic_installation = false,
    }
  end

  -- Nastav všechny servery (funguje i když jsou binárky už systémově)
  for _, s in ipairs(all_servers) do
    setup_server(s)
  end
end

return M

