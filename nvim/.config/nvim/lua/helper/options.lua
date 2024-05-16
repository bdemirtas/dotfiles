vim.g.lsp_zero_ui_float_border = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.scrolloff = 999
vim.filetype.add({
	extension = {
		yml = "yaml.ansible",
	},
	pattern = {
		[".*/tasks/.*.yaml"] = "yaml.ansible",
	},
})
