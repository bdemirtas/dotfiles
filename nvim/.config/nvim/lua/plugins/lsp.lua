return {
  {
    -- JSON/YAML schema support for LSP
    "b0o/schemastore.nvim",
  },
  {
    -- auto-install LSP servers, formatters, linters
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "debugpy",
        "stylua",
        "prettier",
        "ruff",
        "lua-language-server",
        "bash-language-server",
        "pyrefly",
        "yaml-language-server",
        "ansible-language-server",
        "html-lsp",
        "css-lsp",
        "json-lsp",
        "typescript-language-server",
        "dockerfile-language-server",
        "terraform-ls",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
  {
    -- LSP/DAP/linter/formatter package manager
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({ max_concurrent_installers = 10 })
    end,
  },
}
