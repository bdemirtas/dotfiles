return {
  {
    -- near-black dark theme, minimal accents
    "WTFox/luna.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("luna")
    end,
  },
  {
    -- backup colorscheme
    "scottmckendry/cyberdream.nvim",
    lazy = true,
  },
}
