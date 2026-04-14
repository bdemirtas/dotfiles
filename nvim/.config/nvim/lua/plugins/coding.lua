return {
  {
    "mikavilpas/blink-ripgrep.nvim",
    dependencies = { "saghen/blink.cmp" },
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      {
        "folke/snacks.nvim",
        opts = {
          terminal = {},
        },
      },
    },
    event = "LspAttach",
    opts = {
      picker = "snacks",
    },
  },
  {
    "smjonas/inc-rename.nvim",
    event = "LspAttach",
    config = function()
      require("inc_rename").setup({
        hl_group = "Substitute",
        input_buffer_type = "snacks",
        preview_empty_name = false,
        save_in_cmdline_history = true,
        show_message = true,
      })
    end,
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local map = vim.keymap.set

      -- Add cursor by matching word/selection
      map({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end, { desc = "Add cursor next match" })
      map({ "n", "x" }, "<C-p>", function() mc.matchAddCursor(-1) end, { desc = "Add cursor prev match" })

      -- Toggle cursors
      map({ "n", "v" }, "<c-q>", mc.toggleCursor, { desc = "Toggle cursor" })

      mc.addKeymapLayer(function(layerSet)
        layerSet({ "n", "x" }, "<C-h>", mc.prevCursor, { desc = "Prev cursor" })
        layerSet({ "n", "x" }, "<C-l>", mc.nextCursor, { desc = "Next cursor" })
        layerSet({ "n", "x" }, "<C-x>", mc.deleteCursor, { desc = "Delete cursor" })

        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter",
    init = function()
      local want = {
        "bash",
        "diff",
        "editorconfig",
        "git_rebase",
        "git_config",
        "htmldjango",
        "jinja",
        "jinja_inline",
        "ssh_config",
        "zsh",
        "lua",
        "luadoc",
        "python",
        "yaml",
        "json",
        "toml",
        "terraform",
        "markdown",
        "markdown_inline",
        "html",
        "css",
        "javascript",
        "typescript",
        "dockerfile",
        "gitcommit",
        "gitignore",
        "vim",
        "vimdoc",
        "regex",
        "sql",
      }
      local ok, config = pcall(require, "nvim-treesitter.config")
      if not ok then
        return
      end
      local installed = config.get_installed()
      local missing = vim.iter(want):filter(function(p) return not vim.tbl_contains(installed, p) end):totable()
      if #missing > 0 then
        require("nvim-treesitter").install(missing)
      end
    end,
  },
  {
    "folke/ts-comments.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Format buffer",
      },
    },
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
        terraform = { "terraform_fmt" },
        fish = { "fish_indent" },
        -- prettier family
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
      },
    },
  },
  {
    "saghen/blink.cmp",
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "none", -- take full control — no Ctrl+N/P anywhere
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-CR>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },

      completion = {
        trigger = {
          show_on_keyword = true,
          show_on_trigger_character = true,
        },
        list = {
          selection = { preselect = true, auto_insert = true },
        },
        menu = {
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
        ghost_text = { enabled = false },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      signature = {
        enabled = true,
        window = { show_documentation = false },
      },

      appearance = {
        nerd_font_variant = "mono",
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "echasnovski/mini.jump",
    version = "*",
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    version = "*",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" },
        python = { "string" },
      },
      fast_wrap = {
        map = "<M-e>",
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "echasnovski/mini.ai",
    version = "*",
    event = "VeryLazy",
    opts = {
      n_lines = 500,
    },
  },
}
