return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { { "prettierd", "prettier" } },
				css = { "prettier" },
				html = { "prettier" },
				json = { "fixjson" },
				yaml = { "yamlfmt" },
				markdown = { "markdownlint" },
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			conform.format({ lsp_fallback = true, async = false, timeout_ms = 5000 })
		end, { desc = "Format file" })
	end,
}
