return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "b0o/schemastore.nvim",
  },
  config = function()
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        -- buffer local mappings
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "LSP: Rename word under cursor"
        keymap.set("n", "gR", vim.lsp.buf.rename, opts)

        opts.desc = "Add workspace folder"
        keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)

        opts.desc = "Remove workspace folder"
        keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)

        opts.desc = "List workspace folders"
        keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    -- enable snippet
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- enable inlay hint
    vim.lsp.inlay_hint.enable(true, { 0 })

    -- change diagnostic symbols in the sign column (gutter)
    local x = vim.diagnostic.severity
    vim.diagnostic.config {
      virtual_text = { prefix = "" },
      signs = {
        text = {
          [x.ERROR] = " ",
          [x.WARN] = " ",
          [x.HINT] = "󰠠 ",
          [x.INFO] = " ",
        },
      },
      underline = true,

      -- do the following for lsp diagnostics:
      -- 1. disable prefix (e.g. number)
      -- 2. sort from the highest severity
      -- 3. include the source where the warn/error come from
      float = { prefix = "", header = "", severity_sort = true, source = true },
    }

    -- lsp server config
    vim.lsp.config("basedpyright", {
      settings = {
        python = {
          ignore = { "*" },
        },
        basedpyright = {
          analysis = {
            inlayHints = {
              callArgumentNames = true,
            },
            autoSearchPaths = true,
            typeCheckingMode = "standard",
            useLibraryCodeForTypes = false,
            allowedUntypedLibraries = true,
            diagnosticMode = "openFilesOnly",
            diagnosticSeverityOverrides = {
              reportGeneralTypeIssues = false,
              reportOptionalMemberAccess = false,
              reportOptionalSubscript = false,
              reportPrivateImportUsage = false,
              reportUnusedExpression = false,
            },
          },
        },
      },
    })
    vim.lsp.config("stylua", {})
    vim.lsp.config("ansiblels", {})
    vim.lsp.config("html", {})
    vim.lsp.config("dockerls", {})
    vim.lsp.config("cssls", {})
    vim.lsp.config("jsonls", {})
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          format = {
            enable = false,
          },
          diagnostics = {
            globals = { "vim", "mp" },
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
    })
    vim.lsp.config("yamlls", {
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
    })
  end,
}
