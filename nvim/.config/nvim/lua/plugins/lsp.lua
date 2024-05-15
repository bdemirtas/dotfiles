return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false,
          vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>', { buffer = bufnr, desc = "Rename Symbole" }),
        })
      end)

      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,

          pyright = function()
            lspconfig.pyright.setup({
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "off",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true
                  }
                }
              }
            })
          end,

          -- this is the "custom handler" for `lua_ls`
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })
    end,
  },
}
