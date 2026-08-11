return {
  {
    -- AI coding agent integration (send context, prompts)
    "nickjvandyke/opencode.nvim",
    version = "*",
    config = function()
      vim.g.opencode_opts = {}
      vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode" })
      vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select OpenCode" })
      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { desc = "Send range to OpenCode", expr = true })
      vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Send line to OpenCode", expr = true })
    end,
  },
  {
    -- peek LSP definitions in floating popup
    "r4ppz/lspeek.nvim",
    event = "LspAttach",
    config = function()
      require("lspeek").setup()
    end,
    keys = {
      { "gp", function() require("lspeek").peek_definition() end, desc = "Peek definition" },
    },
  },
  {
    -- code lenses above functions: references, author, diagnostics
    "oribarilan/lensline.nvim",
    event = "LspAttach",
    opts = {},
  },
  {
    -- auto-indent pasted code
    "nemanjamalesija/smart-paste.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    -- YAML/JSON/TOML graph explorer
    "Owen-Dechow/videre.nvim",
    cmd = "Videre",
    dependencies = {
      "Owen-Dechow/graph_view_yaml_parser",
      "Owen-Dechow/graph_view_toml_parser",
    },
    keys = {
      { "<leader>sv", "<cmd>Videre<cr>", desc = "Explore YAML/JSON/TOML" },
    },
  },
  {
    -- ripgrep source for blink.cmp
    "mikavilpas/blink-ripgrep.nvim",
    dependencies = { "saghen/blink.cmp" },
  },
  {
    -- snacks-style code action picker
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
    -- add/delete/change surrounding chars: ys, ds, cs
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    -- which-key hints for available surround pairs
    "gregorias/nvim-surround-wk",
    dependencies = { "kylechui/nvim-surround" },
    config = true,
  },
  {
    -- multiple cursors like vscode
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local map = vim.keymap.set

      map({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end, { desc = "Add cursor next match" })
      map({ "n", "x" }, "<C-p>", function() mc.matchAddCursor(-1) end, { desc = "Add cursor prev match" })

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
    -- syntax highlighting and folding
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
          if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start(ev.buf, lang)
          end
        end,
      })

      require("nvim-treesitter").install({
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
      })
    end,
  },
  {
    -- smart comment toggling, context-aware
    "folke/ts-comments.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    -- format-on-save: ruff, prettier, stylua, terraform_fmt
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        desc = "Format buffer",
      },
    },
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
        terraform = { "terraform_fmt" },
        fish = { "fish_indent" },
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
    -- fast LSP completion engine
    "saghen/blink.cmp",
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "none",
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
        default = { "lazydev", "lsp", "path", "snippets", "buffer", "ripgrep" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            opts = {},
          },
        },
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
    -- enhanced f/F/t/T with repeat via ;
    "nvim-mini/mini.jump",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    -- auto-close brackets, quotes, parens
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
    -- LSP for Lua/Neovim config
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    -- text objects: va), di", ci[, and custom
    "nvim-mini/mini.ai",
    version = "*",
    event = "VeryLazy",
    opts = {
      n_lines = 500,
    },
  },
}
