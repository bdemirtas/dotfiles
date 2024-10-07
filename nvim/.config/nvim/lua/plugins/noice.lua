return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup {
      lsp = {
        signature = {
          enabled = false,
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    }
  end,
  vim.keymap.set("n", "<leader>nl", ":Noice last<cr>", { desc = "Last" }),
  vim.keymap.set("n", "<leader>nh", ":Noice history<cr>", { desc = "History" }),
  vim.keymap.set("n", "<leader>nc", ":Noice dismiss<cr>", { desc = "Dismiss" }),
  vim.keymap.set("n", "<leader>ne", ":Noice errors<cr>", { desc = "Errors" }),
  vim.keymap.set("n", "<leader>nt", ":Noice telescope<cr>", { desc = "Telescope" }),
}
