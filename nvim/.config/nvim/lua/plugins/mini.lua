return {
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup {}
    end,
  },
  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup {}
    end,
  },
  {
    "echasnovski/mini.comment",
    version = false,
    config = function()
      require("mini.comment").setup {}
    end,
  },
  {
    "echasnovski/mini.align",
    version = false,
    config = function()
      require("mini.align").setup {}
    end,
  },
  {
    "echasnovski/mini.move",
    config = function()
      require("mini.move").setup {
        mappings = {
          left = "<M-Left>",
          line_left = "<M-Left>",
          right = "<M-Right>",
          line_right = "<M-Right>",
          down = "<M-Down>",
          line_down = "<M-Down>",
          up = "<M-Up>",
          line_up = "<M-Up>",
        },
      }
    end,
  },
}
