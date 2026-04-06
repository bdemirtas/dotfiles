return {
  "folke/snacks.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    gitbrowse = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
    notifier = {
      enabled = true,
      border = "rounded",
      wo = { winblend = 5, wrap = false },
    },
    lsp = {
      progress = {
        enabled = true,
      },
    },
    picker = {
      layout = { preset = "dropdown" },
      win = {
        input = {
          keys = {
            ["<C-j>"] = { "list_down", mode = { "i", "n" } },
            ["<C-k>"] = { "list_up", mode = { "i", "n" } },
          },
        },
      },
    },
    explorer = {
      win = {
        keys = {
          ["<C-h>"] = function() vim.cmd("wincmd h") end,
          ["<C-l>"] = function() vim.cmd("wincmd l") end,
          ["<C-j>"] = function() vim.cmd("wincmd j") end,
          ["<C-k>"] = function() vim.cmd("wincmd k") end,
        },
      },
    },
    indent = { enabled = true, char = "│" },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    input = {
      icon = " ",
      icon_pos = "left",
      prompt_pos = "title",
      win = { style = "input" },
    },
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
  keys = {
    -- Explorer
    {
      "<leader>e",
      function() Snacks.explorer() end,
      desc = "Explorer",
    },
    -- Pickers — Find
    {
      "<leader><space>",
      function() Snacks.picker.smart() end,
      desc = "Smart find files",
    },
    {
      "<leader>ff",
      function() Snacks.picker.files() end,
      desc = "Find files",
    },
    {
      "<leader>fr",
      function() Snacks.picker.recent() end,
      desc = "Recent files",
    },
    {
      "<leader>fb",
      function() Snacks.picker.buffers() end,
      desc = "Buffers",
    },
    {
      "<leader>fc",
      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
      desc = "Find config file",
    },
    -- Pickers — Search/Grep
    {
      "<leader>sg",
      function() Snacks.picker.grep() end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function() Snacks.picker.grep_word() end,
      desc = "Grep word",
      mode = { "n", "x" },
    },
    {
      "<leader>sb",
      function() Snacks.picker.lines() end,
      desc = "Buffer lines",
    },
    -- Pickers — Git
    {
      "<leader>gc",
      function() Snacks.picker.git_log() end,
      desc = "Git log",
    },
    {
      "<leader>gs",
      function() Snacks.picker.git_status() end,
      desc = "Git status",
    },
    {
      "<leader>gB",
      function() Snacks.gitbrowse() end,
      desc = "Git browse",
      mode = { "n", "v" },
    },
    {
      "<leader>gb",
      function() Snacks.git.blame_line() end,
      desc = "Git blame line",
    },
    -- Pickers — Search
    {
      "<leader>sd",
      function() Snacks.picker.diagnostics() end,
      desc = "Diagnostics",
    },
    {
      "<leader>sh",
      function() Snacks.picker.help() end,
      desc = "Help pages",
    },
    {
      "<leader>sk",
      function() Snacks.picker.keymaps() end,
      desc = "Keymaps",
    },
    {
      "<leader>sR",
      function() Snacks.picker.resume() end,
      desc = "Resume picker",
    },
    {
      "<leader>uC",
      function() Snacks.picker.colorschemes() end,
      desc = "Colorschemes",
    },
    -- Notifications
    {
      "<leader>n",
      function() Snacks.notifier.show_history() end,
      desc = "Notification history",
    },
    {
      "<leader>un",
      function() Snacks.notifier.hide() end,
      desc = "Dismiss notifications",
    },
    -- Misc
    {
      "<leader>.",
      function() Snacks.scratch() end,
      desc = "Scratch buffer",
    },
    {
      "<leader>z",
      function() Snacks.zen() end,
      desc = "Zen mode",
    },
    -- LSP (wired after snacks loads)
    {
      "gd",
      function() Snacks.picker.lsp_definitions() end,
      desc = "Go to definition",
    },
    {
      "gr",
      function() Snacks.picker.lsp_references() end,
      desc = "References",
      nowait = true,
    },
    {
      "gI",
      function() Snacks.picker.lsp_implementations() end,
      desc = "Go to implementation",
    },
    {
      "gy",
      function() Snacks.picker.lsp_type_definitions() end,
      desc = "Go to type definition",
    },
    {
      "<leader>ss",
      function() Snacks.picker.lsp_symbols() end,
      desc = "LSP symbols",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd

        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle
          .option("background", {
            off = "light",
            on = "dark",
            name = "Dark background",
          })
          :map("<leader>ub")
      end,
    })
  end,
}
