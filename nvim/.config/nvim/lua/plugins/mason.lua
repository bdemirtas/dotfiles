local servers = {
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
	"html",
	"marksman",
	"ansiblels",
	"pyright",
  "rust_analyzer",
}

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
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({ ensure_installed = servers })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local map = function(m, lhs, rhs, desc, buffer)
				local key_opts = { noremap = true, silent = true, buffer = buffer, desc = desc }
				vim.keymap.set(m, lhs, rhs, key_opts)
			end

			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Mappings to magical LSP functions!
				map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover documentation", bufnr)
				map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition", bufnr)
				map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration", bufnr)
				map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation", bufnr)
				map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition", bufnr)
				map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to reference", bufnr)
				map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show function signature", bufnr)
				map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol", bufnr)
				map({ "n", "x" }, "gR", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", bufnr)
				map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Execute code action", bufnr)
				map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Show diagnostic", bufnr)
				map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic", bufnr)
				map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic", bufnr)
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local lspconfig = require("lspconfig")
			for _, lsp in pairs(servers) do
				lspconfig[lsp].setup({
					on_attach = on_attach,
					capabilites = capabilities,
				})
			end

			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "none",
							diagnosticSeverityOverrides = {
								reportOptionalMemberAccess = "none",
								reportGeneralTypeIssues = "none",
								reportCallIssue = false,
								reportArgumentType = false,
							},
						},
					},
				},
			})

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = {
								"vim",
								"require",
							},
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event) end,
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				severity_sort = false,
				float = true,
			})
		end,
	},
}
