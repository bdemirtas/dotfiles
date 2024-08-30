return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "AckslD/muren.nvim",
    config = function()
      require("muren").setup {
        -- ui sizes
        patterns_width = 50,
        patterns_height = 20,
        options_width = 30,
        preview_height = 12,
      }
    end,
  },
  {
    "mbbill/undotree",
    keys = {
      { "<Leader><F5>", "<Cmd>UndotreeToggle<CR>", desc = "Toggle undotree window", mode = "n", silent = true },
    },
  },
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup {}
    end,
    event = "VeryLazy",
  },
  {
    "danilamihailov/beacon.nvim",
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.g.VM_theme = "purplegray"
      vim.g.VM_set_statusline = 0
      vim.cmd [[
      let g:VM_maps = {}
      let g:VM_maps['Find Under'] = "<C-n>"

      let g:VM_maps['I BS'] = "" " disable backspace mapping
      let g:VM_maps['I CtrlC'] = "" " disable backspace mapping

      ]]
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move to left split",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move to below split",
      },
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to above split",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move to right split",
      },
    },
  },
}
