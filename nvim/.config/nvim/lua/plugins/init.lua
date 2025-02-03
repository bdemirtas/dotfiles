return {
-- stylua: ignore start
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function ()
      return require "configs.snacks"
    end,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          -- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          -- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          -- Snacks.toggle.line_number():map("<leader>ul")
          -- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          -- Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
    keys = {
      { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
      { "<leader>e", function () Snacks.explorer() end, desc = "Explorer"},
      { "<leader><space>", function() Snacks.picker.files() end, desc = "Find Files" },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      -- git
      { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      { "<leader>qp", function() Snacks.picker.projects() end, desc = "Projects" },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    },
  },
  -- stylua: ignore end
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
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      vim.cmd "colorscheme rose-pine"
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
      return require "configs.mason"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require("configs.lspconfig").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      floating_window_off_x = 5, -- adjust float windows x position.
      floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
        local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
        local pumheight = vim.o.pumheight
        local winline = vim.fn.winline() -- line number in the window
        local winheight = vim.fn.winheight(0)

        -- window top
        if winline - 1 < pumheight then
          return pumheight
        end

        -- window bottom
        if winheight - winline < pumheight then
          return -pumheight
        end
        return 0
      end,
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "configs.luasnip"
        end,
      },
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "lukas-reineke/cmp-under-comparator",
      },
    },
    opts = function()
      local opts = require "configs.cmp"
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function()
      require "configs.treesitter"
    end,
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
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require "which-key"

      wk.add {
        { "<leader>c", group = "Code" },
        {
          "<leader>b",
          group = "Buffers",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
          { "<leader>f", group = "Find" },
          { "<leader>g", group = "Git" },
          { "<leader>n", group = "Noice" },
          { "<leader>s", group = "Search" },
          { "<leader>t", group = "Terminal" },
          { "<leader>w", group = "Workspace" },
          { "<leader>u", group = "UI" },
        },
      }
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup {}
      vim.keymap.set("n", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
      vim.diagnostic.config { virtual_lines = false }
    end,
  },
}
