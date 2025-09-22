return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kdheepak/lazygit.nvim",
      lazy = true,
      cmd = {
          "LazyGit",
          "LazyGitConfig",
          "LazyGitCurrentFile",
          "LazyGitFilter",
          "LazyGitFilterCurrentFile",
      },
      -- optional for floating window border decoration
      dependencies = {
          "nvim-lua/plenary.nvim",
      },
      -- setting the keybinding for LazyGit with 'keys' is recommended in
      -- order to load the plugin when the command is run for the first time
      keys = {
          { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" }
      }
  },
  {
    "stevearc/oil.nvim",
    lazy = false,  -- klidně nech, Oil sám doporučuje nelazovat
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- which-key v3 „Suggested Spec“ – mapy se propíšou i do NvCheatsheetu
    keys = {
      { "<leader>o",  group = "Oil" },
      { "<leader>oo", function() require("oil").open() end,                                      desc = "Open (here)",  mode = "n" },
      { "<leader>of", function() require("oil").open_float() end,                                desc = "Open (float)", mode = "n" },
      { "<leader>or", function() require("oil").refresh() end,                                   desc = "Refresh",      mode = "n" },
      { "<leader>ou", function() require("oil").open("..") end,                                  desc = "Up directory", mode = "n" },
      { "<leader>oh", function() require("oil").set_columns({ "icon","permissions","size","mtime" }) end,
                                                                                                 desc = "Show columns", mode = "n" },
      { "<leader>ot", "<cmd>Oil --float<CR>",                                                    desc = "Toggle float", mode = "n" },
    },
    -- tvoje detailní nastavení Oilu si nech v configs.oil (může obsahovat i bufferové keymaps s desc)
    opts = require "configs.oil",
  }

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
