return {
	{
		"echasnovski/mini.align",
		version = false,
		config = function()
			require("mini.align").setup({})
		end,
	},
	{
		"echasnovski/mini.jump2d",
		version = false,
		config = function()
			require("mini.jump2d").setup({})
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
    enabled = false,
		config = function()
			require("mini.surround").setup({})
		end,
	},
	{
		"echasnovski/mini.move",
		config = function()
			require("mini.move").setup({
				mappings = {
					left = "<M-Left>",
					line_left = "<M-Left>",
					right = "<M-Right>",
					line_right = "<M-Right>",
					down = "<M-Down>",
					line_down = "<M-Down>",
					up = "<M-Up>",
					line_up = "<M-Up>",
				},
			})
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		config = function()
			require("mini.indentscope").setup({})
		end,
	},
	{
		"echasnovski/mini.bufremove",
		version = false,
		config = function()
			require("mini.bufremove").setup({})
		end,
	},
	{
		"echasnovski/mini.sessions",
		version = false,
		config = function()
			require("mini.sessions").setup({})
		end,
	},
}
