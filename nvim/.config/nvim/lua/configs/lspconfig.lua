local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", require("fzf-lua").lsp_declarations, opts "Go to declaration")
  map("n", "gd", require("fzf-lua").lsp_definitions, opts "Go to definition")
  map("n", "gi", require("fzf-lua").lsp_implementations, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", require("fzf-lua").lsp_typedefs, opts "Go to type definition")

  map({ "n", "v" }, "<leader>ca", require("fzf-lua").lsp_code_actions, opts "Code action")
  map("n", "gr", require("fzf-lua").lsp_references, opts "Show references")
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  local servers = {
    ansiblels = {},
    jsonls = {},
    bashls = {},
    jqls = {},
    cssls = {},
    marksman = {},
    taplo = {},
    basedpyright = {
      settings = {
        basedpyright = {
          -- Using Ruff's import organizer
          disableOrganizeImports = true,
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            typeCheckingMode = "basic",
            useLibraryCodeForTypes = false,
            diagnosticSeverityOverrides = {
              reportGeneralTypeIssues = false,
              reportOptionalMemberAccess = false,
              reportOptionalSubscript = false,
              reportPrivateImportUsage = false,
              reportUnusedExpression = false,
            },
          },
        },
        python = {
          ignore = { "*" },
        },
      },
    },
    yamlls = {
      settings = {
        yamll = {
          schemas = {
            ["http://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
            ["http://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
            ["http://json.schemastore.org/gitlab-ci.json"] = "/*lab-ci.{yml,yaml}",
            ["https://json.schemastore.org/databricks-asset-bundles.json"] = ".databricks.{yml,yaml}",
          },
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              vim.fn.expand "$VIMRUNTIME/lua",
              vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
              vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
              vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
              "${3rd}/luv/library",
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    },
  }
  for name, opts in pairs(servers) do
    opts.on_init = M.on_init
    opts.on_attach = M.on_attach
    opts.capabilities = M.capabilities
    require("lspconfig")[name].setup(opts)
  end
end

return M
