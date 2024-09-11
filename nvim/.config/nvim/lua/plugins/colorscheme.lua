return {
  "Luxed/ayu-vim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.ayucolor = "dark"
    vim.g.ayu_italic_comment = true
    vim.g.ayu_extended_palette = true
    vim.cmd "colorscheme ayu"
  end,
}
