local M = {}
local map = vim.keymap.set

local on_attach = function(_, bufnr)
  local signature_setup = {
    floating_window = true,
    timer_interval = 10,
  }
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")
  map("n", "<leader>D", function() Snacks.picker.lsp_type_definitions() end, opts "Go to type definition")
  require("lsp_signature").setup(signature_setup)
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local servers = {
  ansiblels = {},
  jsonls = {},
  bashls = {},
  jqls = {},
  cssls = {},
  marksman = {},
  taplo = {},
  terraformls = {},
  pyright = {
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          typeCheckingMode = "off",
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
      yaml = {
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

M.setup = function()
  local lspconfig = require "lspconfig"
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  for server_name, config in pairs(servers) do
    config.capabilities = capabilities
    config.handlers = handlers
    config.on_attach = on_attach
    lspconfig[server_name].setup(config)
  end
end

return M
