return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
        "ruff",
        "lua-language-server",
        "bash-language-server",
        "basedpyright",
        "yaml-language-server",
        "ansible-language-server",
        "html-lsp",
        "css-lsp",
        "json-lsp",
        "dockerfile-language-server",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
  {
    "williamboman/mason.nvim", -- already declared above, lazy dedupes it
    config = function()
      require("mason").setup({ max_concurrent_installers = 10 })
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
    end,
  },
}
