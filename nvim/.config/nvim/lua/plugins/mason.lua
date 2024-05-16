servers = {
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
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

			local map = function(m, lhs, rhs, desc, buffer)
				local key_opts = { buffer = buffer, desc = desc }
				vim.keymap.set(m, lhs, rhs, key_opts)
			end
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover documentation", event.buf)
					map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition", event.buf)
					map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration", event.buf)
					map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation", event.buf)
					map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition", event.buf)
					map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to reference", event.buf)
					map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show function signature", event.buf)
					map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol", event.buf)
					map({ "n", "x" }, "gR", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", event.buf)
					map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Execute code action", event.buf)
					map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Show diagnostic", event.buf)
					map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic", event.buf)
					map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic", event.buf)
				end,
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
