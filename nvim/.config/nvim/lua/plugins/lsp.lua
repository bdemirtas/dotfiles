local lsp_servers = {
  "lua_ls",
  "marksman",
  "yamlls",
  "bashls",
  "dockerls",
  "jsonls",
  "jqls",
  "marksman",
  "cssls",
  "taplo",
  "ruff",
  "basedpyright",
  "html",
  "marksman",
  "ansible-language-server",
}

local lint_servers = {
  "ansible-lint",
  "eslint_d",
  "prettier",
  "fixjson",
  "jq",
  "ruff",
  "yamlfmt",
  "markdownlint",
  "stylua",
  "ast-grep",
}

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup {}
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = vim.tbl_extend("force", lint_servers, lsp_servers),
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require "lspconfig"
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local builtin = require "telescope.builtin"
          local nmap = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          nmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover documentation")
          nmap("n", "gd", builtin.lsp_definitions, "Go to definition")
          nmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration() <cr>", "Go to declaration")
          nmap("n", "gi", builtin.lsp_implementations, "Go to implementation")
          nmap("n", "go", builtin.lsp_type_definitions, "Go to definition")
          nmap("n", "gr", builtin.lsp_references, "Go to references")
          nmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Documentation")
          nmap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbole")
          nmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action")
          nmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic")
          nmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic")
          if client ~= nil and client.name == "ruff" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, lsp in pairs(lsp_servers) do
        lspconfig[lsp].setup {
          capabilites = capabilities,
        }
      end

      lspconfig.ansiblels.setup {}

      lspconfig.basedpyright.setup {
        settings = {
          basedpyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
              useLibraryCodeForTypes = false,
              reportPrivateImportUsage = false,
            },
          },
          python = {
            ignore = { "*" },
          },
        },
      }

      lspconfig.yamlls.setup {
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
      }

      lspconfig.lua_ls.setup {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              },
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              -- library = vim.api.nvim_get_runtime_file("", true)
            },
          })
        end,
        settings = {
          Lua = {},
        },
      }

      vim.diagnostic.config {
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = false,
        float = true,
      }
    end,
  },
}
