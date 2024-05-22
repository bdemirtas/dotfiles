return {
	{
		"famiu/bufdelete.nvim",
	},
	{
		"j-morano/buffer_manager.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		lazy = false,
		keys = {
			{ "<leader>db", ":Bdelete<CR>", desc = "Delete Buffer" },
		},
		config = function()
			require("buffer_manager").setup({
				vim.keymap.set(
					{ "t", "n" },
					"<leader>fb",
					require("buffer_manager.ui").toggle_quick_menu,
					{ noremap = true, desc = "Buffers List" }
				),

				select_menu_item_commands = {
					v = {
						key = "<C-v>",
						command = "vsplit",
					},
					h = {
						key = "<C-h>",
						command = "split",
					},
				},
				focus_alternate_buffer = false,
				short_file_names = true,
        order_buffers = "filename",
				loop_nav = true,
				highlight = "Normal:BufferManagerBorder",
				win_extra_options = {
					winhighlight = "Normal:BufferManagerNormal",
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		keys = {
			{ "<leader>dP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>do", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
			{
				"<leader>dr",
				"<Cmd>BufferLineCloseRight<CR>",
				desc = "Delete Buffers to the Right",
			},
			{
				"<leader>dl",
				"<Cmd>BufferLineCloseLeft<CR>",
				desc = "Delete Buffers to the Left",
			},
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		},
		opts = {
			options = {
				-- -- stylua: ignore
				-- close_command = function(n) require("mini.bufremove").delete(n, false) end,
				-- -- stylua: ignore
				-- right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "neo-tree",
						-- text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd("BufAdd", {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},
}
