return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local ok, oil = pcall(require, "oil")
    if not ok then return end

    oil.setup({
      default_file_explorer = true,
      columns = { "icon" },

      buf_options = { buflisted = false, bufhidden = "hide" },
      win_options = {
        wrap = false, signcolumn = "no", cursorcolumn = false, foldcolumn = "0",
        spell = false, list = false, conceallevel = 3, concealcursor = "nvic",
      },

      delete_to_trash = false,
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
      cleanup_delay_ms = 2000,

      lsp_file_methods = { enabled = true, timeout_ms = 1000, autosave_changes = false },

      constrain_cursor = "editable",
      watch_for_changes = false,

      -- buffer-lokální mapy (ukážou se ve which-key po prefixu `g` v Oil bufferu)
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n", desc = "Oil: Help" },
        ["<CR>"] = { "actions.select", desc = "Open" },
        ["-"] = { "actions.parent", mode = "n", desc = "Up directory" },
        ["_"] = { "actions.open_cwd", mode = "n", desc = "Open CWD" },
        ["`"] = { "actions.cd", mode = "n", desc = "cd here" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n", desc = "cd (tab)" },
        ["gs"] = { "actions.change_sort", mode = "n", desc = "Change sort" },
        ["gx"] = { "actions.open_external", desc = "Open externally" },
        ["g."] = { "actions.toggle_hidden", mode = "n", desc = "Toggle dotfiles" },
        ["g\\"] = { "actions.toggle_trash", mode = "n", desc = "Toggle trash view" },
      },

      use_default_keymaps = true,

      view_options = {
        show_hidden = false,
        is_hidden_file = function(name) return name:sub(1,1) == "." end,
        is_always_hidden = function(_) return false end,
        natural_order = "fast",
        case_insensitive = false,
        sort = { { "type", "asc" }, { "name", "asc" } },
      },

      float = {
        padding = 2, max_width = 0, max_height = 0, border = "rounded",
        win_options = { winblend = 0 }, preview_split = "auto",
        override = function(conf) return conf end,
      },

      preview_win = {
        update_on_cursor_moved = true,
        preview_method = "fast_scratch",
        disable_preview = function(_) return false end,
        win_options = {},
      },

      confirmation = {
        max_width = 0.9, min_width = {40, 0.4},
        max_height = 0.9, min_height = {5, 0.1},
        border = "rounded",
        win_options = { winblend = 0 },
      },

      progress = {
        max_width = 0.9, min_width = {40, 0.4},
        max_height = {10, 0.9}, min_height = {5, 0.1},
        border = "rounded", minimized_border = "none",
        win_options = { winblend = 0 },
      },

      ssh = { border = "rounded" },
      keymaps_help = { border = "rounded" },
    })
  end,
}

