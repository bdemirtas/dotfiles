return {
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = true,
	},
	{
		"roobert/surround-ui.nvim",
		dependencies = {
			"kylechui/nvim-surround",
			"folke/which-key.nvim",
		},
		config = function()
			require("surround-ui").setup({
				root_key = "S",
			})
		end,
	},
	{
		"danilamihailov/beacon.nvim",
	},
	{
		"mg979/vim-visual-multi",
		branch = "master",
		event = { "BufReadPre", "BufNewFile" },
		init = function()
			vim.g.VM_theme = "purplegray"
			vim.g.VM_set_statusline = 0
			vim.cmd([[
      " To change any mapping you must first initialize the variable:
      let g:VM_maps = {}
      let g:VM_maps['Find Under'] = "<C-n>"

      " https://github.com/mg979/vim-visual-multi/issues/172
      let g:VM_maps['I BS'] = "" " disable backspace mapping
      let g:VM_maps['I CtrlC'] = "" " disable backspace mapping

      ]])
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<A-k>",
				function()
					require("smart-splits").resize_up(2)
				end,
				desc = "Resize split up",
			},
			{
				"<A-j>",
				function()
					require("smart-splits").resize_down(2)
				end,
				desc = "Resize split down",
			},
			{
				"<A-h>",
				function()
					require("smart-splits").resize_left(2)
				end,
				desc = "Resize split left",
			},
			{
				"<A-l>",
				function()
					require("smart-splits").resize_right(2)
				end,
				desc = "Resize split right",
			},
			{
				"<C-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				desc = "Move to left split",
			},
			{
				"<C-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				desc = "Move to below split",
			},
			{
				"<C-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				desc = "Move to above split",
			},
			{
				"<C-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				desc = "Move to right split",
			},
		},
	},
	-- Comment with haste
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	-- Better buffer closing actions. Available via the buffers helper.
	{
		"kazhala/close-buffers.nvim",
		opts = {
			preserve_window_layout = { "this", "nameless" },
		},
	},
	-- "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	-- "tpope/vim-surround", -- Surround stuff with the ys-, cs-, ds- commands
}
