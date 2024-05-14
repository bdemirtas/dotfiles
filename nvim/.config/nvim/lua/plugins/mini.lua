return {
  {
    'echasnovski/mini.align',
    version = false,
    config = function()
      require("mini.align").setup({})
    end
  },
  {
    'echasnovski/mini.jump2d',
    version = false,
    config = function()
      require('mini.jump2d').setup({})
    end
  },
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require('mini.surround').setup({})
    end
  },
  {
    "echasnovski/mini.move",
    config = function()
      require("mini.move").setup({})
    end,
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require('mini.indentscope').setup({})
    end
  },
  {
    'echasnovski/mini.bufremove',
    version = false,
    config = function()
      require('mini.bufremove').setup({})
    end
  },
  {
    'echasnovski/mini.notify',
    version = false,
    config = function()
      require('mini.notify').setup({})
    end
  },
  {
    'echasnovski/mini.sessions',
    version = false,
    config = function()
      require('mini.sessions').setup({})
    end
  },
}
