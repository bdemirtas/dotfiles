return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup {
      theme = "hyper",
      config = {
        packages = { enable = true },
        project = {
          enable = true,
          limit = 8,
          icon = "📘",
          action = "Telescope projects cwd=",
        },
        header = {},
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            desc = "Mason",
            group = "@property",
            action = "Mason",
            key = "m",
          },
          {
            desc = "Lazy",
            group = "@property",
            action = "Lazy",
            key = "p",
          },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = " Apps",
            group = "DiagnosticHint",
            action = "Telescope projects",
            key = "a",
          },
        },
        mru = {
          limit = 15,
          cwd_only = false,
          icon = "🕕",
        },
        footer = {
          "🎉 No Code, No Bug 🎉",
        },
      },
    }
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
