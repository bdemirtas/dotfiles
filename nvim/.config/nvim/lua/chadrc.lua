local M = {}

M.base46 = {
  theme = "dark_horizon",
}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "block",
  },
  telescope = {
    style = "borderless",
  },
  tabufline = {
    enabled = true,
  },
  cmp = {
    lspkind_text = true,
    style = "default",
    icons_left = true,
    format_colors = {
      tailwind = false,
    },
  },
}
M.nvdash = {
  load_on_startup = false,
}

M.lsp = {
  signature = true,
}

return M
