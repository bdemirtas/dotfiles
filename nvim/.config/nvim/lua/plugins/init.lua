return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = function()
      return require "config.noice"
    end,
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    keys = {
      {
        "<leader>bP",
        "<Cmd>BufferCloseAllButCurrentOrPinned<CR>",
        desc = "Delete Non-Pinned Buffers",
      },
      {
        "<leader>bp",
        "<Cmd>BufferPin<CR>",
        desc = "Pin Buffers",
      },
      { "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Delete Other Buffers" },
      {
        "<leader>bd",
        "<Cmd>BufferClose<CR>",
        desc = "Delete Buffer",
      },
      {
        "<leader>br",
        "<Cmd>BufferCloseBuffersRight<CR>",
        desc = "Delete Buffers to the Right",
      },
      {
        "<leader>bl",
        "<Cmd>BufferCloseBuffersLeft<CR>",
        desc = "Delete Buffers to the Left",
      },
      { "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
    },
    version = "^1.0.0",
    config = function()
      require("barbar").setup {
        sidebar_filetypes = {
          ["neo-tree"] = {
            event = "BufWipeout",
          },
        },
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.cmd "colorscheme catppuccin-frappe"
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      max_concurrent_installers = 10,
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup {}
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    opts = function()
      return require "config.mason"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    lazy = false,
    config = function()
      require("config.lspconfig").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "json",
        "luadoc",
        "bash",
        "git_config",
        "csv",
        "vim",
        "python",
        "toml",
        "jq",
        "json",
        "ocaml",
        "xml",
        "terraform",
        "lua",
        "gitignore",
        "gitcommit",
        "git_rebase",
        "yaml",
        "sql",
        "markdown",
        "markdown_inline",
        "regex",
        "norg",
      },
      ignore_install = {},
      sync_install = false,
      indent = {
        enable = true,
      },
      auto_install = true,
      highlight = { enable = true },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        ansible = { "ansible-lint" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        fish = { "fish_indent" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
        terraform = { "terraform_fmt" },
      },
    },
  },
  {
    "echasnovski/mini.diff",
    version = false,
    config = function()
      require("mini.diff").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup {}
    end,
  },
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup {}
    end,
  },
  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup {}
    end,
  },
  {
    "echasnovski/mini.comment",
    version = false,
    config = function()
      require("mini.comment").setup {}
    end,
  },
  {
    "echasnovski/mini.align",
    version = false,
    config = function()
      require("mini.align").setup {}
    end,
  },
  {
    "echasnovski/mini.move",
    config = function()
      require("mini.move").setup {}
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {}
    end,
  },
  {
    "chrisgrieser/nvim-spider",
    -- stylua: ignore
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'x', 'n', 'o' }, },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'x', 'n', 'o' }, },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'x', 'n', 'o' }, },
      { 'ge', "<cmd>lua require('spider').motion('ge')<CR>", mode = { 'x', 'n', 'o' }, },
    },
  },
  {
    "mg979/vim-visual-multi",
    version = "*",
    opts = {},
    vscode = false,
    config = function() end,
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require "grug-far"
          local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          }
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      { "<Leader><F5>", "<Cmd>UndotreeToggle<CR>", desc = "Toggle undotree window", mode = "n", silent = true },
    },
  },
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup {}
    end,
    event = "VeryLazy",
  },
  {
    "danilamihailov/beacon.nvim",
  },
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
  },
  {
    "folke/todo-comments.nvim",
    optional = true,
    keys = {
      {
        "<leader>st",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          Snacks.picker.todo_comments { keywords = { "TODO", "FIX", "FIXME" } }
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },
  {
    "fredeeb/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      { "<leader>gt", "<cmd>Tardis<cr>", desc = "Time Machine" },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("neogit").setup {
        vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" }),
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup {
        size = 10,
        open_mapping = { "<F12>", [[<M-\>]] },
        direction = "float",
      }
    end,
  },
  {
    "folke/trouble.nvim",
    optional = true,
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
                },
              },
            },
          },
        })
      end,
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 300,
      icons = {
        rules = false,
        breadcrumb = " ", -- symbol used in the command line area that shows your active key combo
        separator = "󱦰  ", -- symbol used between a key and it's label
        group = "󰹍 ", -- symbol prepended to a group
      },
      plugins = {
        spelling = {
          enabled = false,
        },
      },
      win = {
        height = {
          max = math.huge,
        },
      },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>f", group = "Find" },
          { "<leader>g", group = "Git" },
          { "<leader>s", group = "Search" },
          { "<leader>t", group = "Terminal" },
          { "<leader>w", group = "Workspace" },
          { "<leader>u", group = "UI" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show { global = false }
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
