return {
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    keys = {
      {
        "<leader>bP",
        "<Cmd>BufferCloseAllButCurrentOrPinned<CR>",
        desc = "Delete Non-Pinned Buffers",
      },
      {
        "<leader>bp",
        "<Cmd>BufferPin<CR>",
        desc = "Pin Buffers",
      },
      { "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Delete Other Buffers" },
      {
        "<leader>bd",
        "<Cmd>BufferClose<CR>",
        desc = "Delete Buffer",
      },
      {
        "<leader>br",
        "<Cmd>BufferCloseBuffersRight<CR>",
        desc = "Delete Buffers to the Right",
      },
      {
        "<leader>bl",
        "<Cmd>BufferCloseBuffersLeft<CR>",
        desc = "Delete Buffers to the Left",
      },
      { "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
    },
    version = "^1.0.0",
    config = function()
      require("barbar").setup {
        sidebar_filetypes = {
          ["neo-tree"] = {
            event = "BufWipeout",
          },
        },
      }
    end,
  },
}
