return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd "colorscheme github_dark_high_contrast"
  end,
}
