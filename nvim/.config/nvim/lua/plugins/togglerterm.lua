return {
  'akinsho/toggleterm.nvim',
  config = function()
    require("toggleterm").setup({
      size = 10,
      open_mapping = { "<F12>", [[<M-\>]] },
      direction = "float",
    })
  end
}
