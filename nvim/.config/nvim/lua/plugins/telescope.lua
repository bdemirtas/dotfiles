return {
	{
		"nvim-telescope/telescope.nvim",
    enabled = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				enabled = vim.fn.executable("make") == 1,
				build = "make",
			},
			"andrew-george/telescope-themes",
			"nvim-telescope/telescope-frecency.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			local map = require("helper.util").Map
			-- find
			map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
			map("n", "<leader>ff", builtin.find_files, { desc = "Find Files (Root Dir)" })
			map("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
			map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
			map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent" })
			-- git
			map("n", "<leader>gc", builtin.git_commits, { desc = "Commits" })
			map("n", "<leader>gc", builtin.git_bcommits, { desc = "Buffer Commits" })
			-- search
			map("n", '<leader>s"', builtin.registers, { desc = "Registers" })
			map("n", "<leader>sa", builtin.autocommands, { desc = "Auto Commands" })
			map("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Buffer" })
			map("n", "<leader>sc", builtin.command_history, { desc = "Command History" })
			map("n", "<leader>sC", builtin.commands, { desc = "Commands" })
			map("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document Diagnostics" })
			map("n", "<leader>sH", builtin.highlights, { desc = "Search Highlight Groups" })
			map("n", "<leader>sD", builtin.diagnostics, { desc = "Workspace Diagnostics" })
			map("n", "<leader>sh", builtin.help_tags, { desc = "Help Pages" })
			map("n", "<leader>sk", builtin.keymaps, { desc = "Key Maps" })
			map("n", "<leader>sM", builtin.man_pages, { desc = "Man Pages" })
			map("n", "<leader>sm", builtin.marks, { desc = "Jump to Mark" })
			map("n", "<leader>so", builtin.vim_options, { desc = "Options" })
			map("n", "<leader>sR", builtin.resume, { desc = "Resume" })
			map("n", "<leader>st", ":Telescope themes<CR>", { desc = "Theme Switcher" })
			local telescope = require("telescope")
			telescope.setup({
				find_files = {
					hidden = true,
				},
				defaults = {
					mappings = {
						i = {
							["<C-h>"] = "which_key",
							["<C-N>"] = actions.cycle_history_next,
							["<C-P>"] = actions.cycle_history_prev,
							["<C-J>"] = actions.move_selection_next,
							["<C-K>"] = actions.move_selection_previous,
						},
						n = { q = actions.close },
					},
				},
				pickers = {
					layout_config = {},
				},
				extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					smart_open = {
						match_algorithm = "fzf",
						disable_devicons = false,
					},
				},
			})
			telescope.load_extension("fzf")
			telescope.load_extension("themes")
			telescope.load_extension("frecency")
			telescope.load_extension("ui-select")
		end,
	},
	{
		"danielfalk/smart-open.nvim",
    enabled = true,
		branch = "0.2.x",
		config = function()
			require("telescope").load_extension("smart_open")
			vim.keymap.set("n", "<leader><leader>", function()
				require("telescope").extensions.smart_open.smart_open()
			end, { noremap = true, silent = true })
		end,
		dependencies = {
			"kkharji/sqlite.lua",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
}
