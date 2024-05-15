return {
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format file" })
      require("mason-null-ls").setup({
        ensure_installed = {
          "jq",
          "eslint_d",
          "ruff",
          "fixjson",
          "jq",
          "yamlfmt",
        },
        handlers = {},
      })
      require("null-ls").setup({
        sources = {
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.prettierd.with({
            disabled_filetypes = { "lua" },
          }),
        },
      })
    end,
  },
}
