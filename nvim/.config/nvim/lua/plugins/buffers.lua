return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "echasnovski/mini.bufremove", "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      {
        "<leader>dP",
        "<Cmd>BufferLineGroupClose ungrouped<CR>",
        desc = "Delete Non-Pinned Buffers",
      },
      { "<leader>do", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      {
        "<leader>db",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>dr",
        "<Cmd>BufferLineCloseRight<CR>",
        desc = "Delete Buffers to the Right",
      },
      {
        "<leader>dl",
        "<Cmd>BufferLineCloseLeft<CR>",
        desc = "Delete Buffers to the Left",
      },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
    config = function()
      require("bufferline").setup {
        options = {
          custom_filter = function(buf_number)
            local filetype = vim.bo[buf_number].filetype
            if filetype == "TelescopePrompt" or filetype == "fzf" then
              return false
            end
            return true
          end,
          close_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,
          diagnostics = "nvim_lsp",
          right_mouse_command = nil,
          middle_mouse_command = nil,
          always_show_bufferline = false,
          diagnostics_update_in_insert = true,
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
  {
    {
      "kazhala/close-buffers.nvim",
      enabled = false,
      opts = {
        preserve_window_layout = { "this", "nameless" },
      },
    },
  },
}
