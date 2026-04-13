vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.enable({
  "lua_ls",
  "basedpyright",
  "yamlls",
  "bashls",
  "ansiblels",
  "html",
  "cssls",
  "jsonls",
  "dockerls",
})
