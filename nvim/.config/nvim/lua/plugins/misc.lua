return {
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup({})
    end,
    event = "VeryLazy",
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    config = true,
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
        "<A-k>",
        function()
          require("smart-splits").resize_up(2)
        end,
        desc = "Resize split up",
      },
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down(2)
        end,
        desc = "Resize split down",
      },
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left(2)
        end,
        desc = "Resize split left",
      },
      {
        "<A-l>",
        function()
          require("smart-splits").resize_right(2)
        end,
        desc = "Resize split right",
      },
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
