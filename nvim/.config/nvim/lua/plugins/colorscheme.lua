return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup {
      palettes = {
        carbonfox = {
          bg1 = "#1e1e1e",
          sel0 = "#4C566A",
        },
      },
    }
    vim.cmd "colorscheme carbonfox"
  end,
}
