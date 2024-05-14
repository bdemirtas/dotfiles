return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.g.VM_theme = "purplegray"
      vim.g.VM_mouse_mappings = 1
    end,
  },
  {
    'mrjones2014/legendary.nvim',
    priority = 10000,
    lazy = false,
    keys = {
      { "<C-S-P>", "<cmd>:Legendary<cr>", desc = "Legendary" },
    },
    config = function()
      require("legendary").setup({
        extensions = {
          lazy_nvim = true,
          which_key = {
            auto_register = true,
          },
          nvim_tree = true,
          smart_splits = {
            directions = { 'h', 'j', 'k', 'l' },
            mods = {
              move = '<C>',
              resize = '<A>',
            },
          },
          op_nvim = true,
          diffview = true,
        },
      })
    end
  },
  {
    'mrjones2014/smart-splits.nvim',
    event = "VeryLazy",
    keys = {
      { '<A-k>', function() require('smart-splits').resize_up(2) end,        desc = "Resize split up" },
      { '<A-j>', function() require('smart-splits').resize_down(2) end,      desc = "Resize split down" },
      { '<A-h>', function() require('smart-splits').resize_left(2) end,      desc = "Resize split left" },
      { '<A-l>', function() require('smart-splits').resize_right(2) end,     desc = "Resize split right" },
      { '<C-k>', function() require('smart-splits').move_cursor_up() end,    desc = "Move to left split" },
      { '<C-j>', function() require('smart-splits').move_cursor_down() end,  desc = "Move to below split" },
      { '<C-h>', function() require('smart-splits').move_cursor_left() end,  desc = "Move to above split" },
      { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = "Move to right split" },
    }
  },
  -- Comment with haste
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  -- Better buffer closing actions. Available via the buffers helper.
  {
    "kazhala/close-buffers.nvim",
    opts = {
      preserve_window_layout = { "this", "nameless" },
    },
  },
  -- "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  -- "tpope/vim-surround", -- Surround stuff with the ys-, cs-, ds- commands
}
