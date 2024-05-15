return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim"
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- LSP
          "typescript-language-server",
          "eslint-lsp",
          "pyright",
          "lua_ls",
          "marksman",
          "yamlls",
          "bashls",
          "dockerls",
          "jsonls",
          "html",
          "jqls",
          "jsonls",
          "marksman",
          "cssls",
          "taplo",
          "ruff_lsp"
        },
      })
    end
  }
}
