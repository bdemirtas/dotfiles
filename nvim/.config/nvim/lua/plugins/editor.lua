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
    -- magit-style git UI: status, staging, committing, branching
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Commit" },
      { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Push" },
      { "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Pull" },
    },
  },
  {
    -- side-by-side git diff viewer
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gdv", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "DiffviewFilePanel", "DiffviewFileHistoryPanel", "DiffviewFiles", "diffview" },
        callback = function(ev)
          vim.keymap.set("n", "q", "<cmd>DiffviewClose<cr>", { buffer = ev.buf, silent = true })
        end,
      })
    end,
  },
  {
    -- jetbrains-style diff with connector gutters
    "CoreyKaylor/diffbandit.nvim",
    config = function() require("diffbandit").setup() end,
    keys = {
      { "<leader>gd", "<cmd>DiffBanditGit<cr>", desc = "Diff working tree" },
      { "<leader>gdm", "<cmd>DiffBanditGit --base develop<cr>", desc = "Diff vs develop" },
      { "<leader>gdh", "<cmd>DiffBanditGitCommit HEAD<cr>", desc = "Diff last commit" },
    },
  },
  {
    -- git time machine: browse file history
    "fredeeb/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gt", "<cmd>Tardis<cr>", desc = "Git time machine" },
    },
    config = function()
      require("tardis-nvim").setup()

      local Session = require("tardis-nvim.session").Session

      function Session:get_current_buffer()
        return self.buffers[self.current_buffer_index]
      end

      function Session:goto_buffer(index)
        if index < 1 or index > #self.log then
          return false
        end
        local buf = self.buffers[index]
        if not buf or not buf.fd or not vim.api.nvim_buf_is_valid(buf.fd) then
          self.buffers[index] = self:create_buffer(index)
        end
        self.buffers[index]:focus()
        self.current_buffer_index = index
        return true
      end

      function Session:next_buffer()
        if not self:goto_buffer(self.current_buffer_index + 1) then
          vim.notify("No earlier revisions of file")
        end
      end

      function Session:prev_buffer()
        if not self:goto_buffer(self.current_buffer_index - 1) then
          vim.notify("No later revisions of file")
        end
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
    -- gutter signs, hunk staging, blame
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
    -- floating search-and-replace
    "ankushbhagats/match.nvim",
    event = "VeryLazy",
    config = function() require("match") end,
    keys = {
      {
        "<leader>sr",
        function() vim.cmd("Match ") end,
        mode = "n",
        desc = "Search and Replace",
      },
      {
        "<leader>sr",
        function() vim.cmd("MatchWord") end,
        mode = "v",
        desc = "Search and Replace",
      },
    },
  },
  {
    -- diagnostics + symbols panel
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
  },
  {
    -- python test coverage inline
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
    -- jump to any visible character
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
