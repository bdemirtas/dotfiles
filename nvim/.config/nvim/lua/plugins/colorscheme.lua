return {
  {
    "kbraggins/duskhaven.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("duskhaven")
    end,
  },
  -- Kept so you can switch back via <leader>uC
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
  },
}
