vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.enable({
  "lua_ls",
  "pyrefly",
  "ts_ls",
  "yamlls",
  "bashls",
  "ansiblels",
  "html",
  "cssls",
  "jsonls",
  "dockerls",
})
