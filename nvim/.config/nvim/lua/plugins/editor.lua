local function project_root()
  return vim.fs.root(0, {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "tox.ini",
    "uv.lock",
    "Pipfile",
    ".git",
  }) or vim.fn.getcwd()
end

return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit" },
      { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Neogit push" },
      { "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Neogit pull" },
    },
  },
  {
    "CoreyKaylor/diffbandit.nvim",
    config = function() require("diffbandit").setup() end,
    keys = {
      { "<leader>gd", "<cmd>DiffBanditGit<cr>", desc = "Diff working tree" },
      { "<leader>gdm", "<cmd>DiffBanditGit --base develop<cr>", desc = "Diff vs develop" },
      { "<leader>gdh", "<cmd>DiffBanditGitCommit HEAD<cr>", desc = "Diff last commit" },
    },
  },
  {
    "fredeeb/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gt", "<cmd>Tardis<cr>", desc = "Git time machine" },
    },
    config = function()
      require("tardis-nvim").setup()

      local Session = require("tardis-nvim.session").Session

      function Session:goto_buffer(index)
        if index < 1 or index > #self.log then
          return false
        end
        local buf = self.buffers[index]
        if not buf or not buf.fd or not vim.api.nvim_buf_is_valid(buf.fd) then
          self.buffers[index] = self:create_buffer(index)
        end
        self.buffers[index]:focus()
        self.curret_buffer_index = index
        return true
      end

      local close = Session.close
      function Session:close()
        if self.info_fd and vim.api.nvim_buf_is_valid(self.info_fd) then
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == self.info_fd then
              vim.api.nvim_win_close(win, false)
            end
          end
          pcall(vim.api.nvim_buf_delete, self.info_fd, { force = true })
          self.info_fd = nil
        end
        if self.origin and vim.api.nvim_buf_is_valid(self.origin) then
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            for _, tardis_buf in pairs(self.buffers) do
              if tardis_buf.fd and buf == tardis_buf.fd then
                vim.api.nvim_win_set_buf(win, self.origin)
              end
            end
          end
        end
        close(self)
      end
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end

        -- Navigation
        map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First hunk")

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>hd", gs.diffthis, "Diff this")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff this ~")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    },
  },
  {
    "ankushbhagats/match.nvim",
    cmd = { "Match", "MatchWord", "MatchLine" },
    keys = {
      {
        "<leader>sr",
        "<cmd>Match<cr>",
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = { focus = true },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    },
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
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "Coverage",
      "CoverageLoad",
      "CoverageLoadLcov",
      "CoverageShow",
      "CoverageHide",
      "CoverageToggle",
      "CoverageSummary",
    },
    keys = {
      {
        "<leader>cL",
        function()
          -- Prefer lcov at project root, else coverage.py .coverage via language loader
          local root = project_root()

          for _, rel in ipairs({ "lcov.info", "coverage/lcov.info", "coverage/coverage.lcov" }) do
            local path = root .. "/" .. rel
            if vim.fn.filereadable(path) == 1 then
              require("coverage").load_lcov(path, true)
              return
            end
          end

          require("coverage").load(true)
        end,
        desc = "Load coverage",
      },
      { "<leader>cv", "<cmd>CoverageToggle<cr>", desc = "Toggle coverage" },
      { "<leader>cS", "<cmd>CoverageSummary<cr>", desc = "Coverage summary" },
    },
    opts = {
      auto_reload = true,
      lang = {
        python = {
          -- Function so path is resolved at load time (not plugin-load cwd)
          coverage_file = function()
            local root = project_root()
            for _, rel in ipairs({ ".coverage", "htmlcov/.coverage" }) do
              local path = root .. "/" .. rel
              if vim.fn.filereadable(path) == 1 then
                return path
              end
            end
            return root .. "/.coverage"
          end,
        },
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        function() require("flash").jump() end,
        desc = "Flash",
        mode = { "n", "x", "o" },
      },
      {
        "S",
        function() require("flash").treesitter() end,
        desc = "Flash treesitter",
        mode = { "n", "x", "o" },
      },
      { "r", function() require("flash").remote() end, desc = "Flash remote", mode = "o" },
      {
        "R",
        function() require("flash").treesitter_search() end,
        desc = "Flash treesitter search",
        mode = { "o", "x" },
      },
      { "<C-s>", function() require("flash").toggle() end, desc = "Toggle flash search", mode = "c" },
    },
  },
}
