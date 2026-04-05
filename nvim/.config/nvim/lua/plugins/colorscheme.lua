return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  opts = {
    -- variant = "moon",
    -- dark_variant = "moon",
    styles = {
      bold = true,
      italic = false,
      transparency = false,
    },
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd.colorscheme "rose-pine"
  end,
}
