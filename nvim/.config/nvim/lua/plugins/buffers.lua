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
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    dependencies = { "echasnovski/mini.bufremove", "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      {
        "<leader>bP",
        "<Cmd>BufferLineGroupClose ungrouped<CR>",
        desc = "Delete Non-Pinned Buffers",
      },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>br",
        "<Cmd>BufferLineCloseRight<CR>",
        desc = "Delete Buffers to the Right",
      },
      {
        "<leader>bl",
        "<Cmd>BufferLineCloseLeft<CR>",
        desc = "Delete Buffers to the Left",
      },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
    config = function()
      require("bufferline").setup {
        options = {
          close_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,
          diagnostics = "nvim_lsp",
          right_mouse_command = nil,
          middle_mouse_command = nil,
          always_show_bufferline = false,
          style = "thick",
          offsets = {
            {
              filetype = "neo-tree",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      }
    end,
  },
}
