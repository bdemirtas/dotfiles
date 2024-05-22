return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
        require("none-ls.formatting.ruff"),
        require("none-ls.formatting.ruff_format"),
      },
		})
		require("mason-null-ls").setup({
			ensure_installed = {
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
			},
			handlers = {},
		})
		vim.keymap.set("n", "gF", vim.lsp.buf.format, { desc = "Format file" })
	end,
}
