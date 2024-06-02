return {
	{
		"nvim-telescope/telescope.nvim",
    enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
      "andrew-george/telescope-themes",
			"nvim-telescope/telescope-frecency.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")
			local map = require("helper.util").Map
			-- find
			map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
			map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "File fuzzy find" })
			map("n", "<leader>ff", builtin.find_files, { desc = "Find Files (Root Dir)" })
			map("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
			map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
			map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent" })
			-- git
			map("n", "<leader>gC", builtin.git_commits, { desc = "Commits" })
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
          layout_strategy = "center",
          results_title = false,
          sorting_strategy = "ascending",
          layout_config = {
            center = {
              width = 0.6,
              height = 0.4,
            },
          },
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
              ["<M-p>"] = action_layout.toggle_preview,
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            },
            n = {
              q = actions.close,
              ["<M-p>"] = action_layout.toggle_preview
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
          },
          buffers = { previewer = false, theme = "dropdown", show_remote_tracking_branches = false },
          current_buffer_fuzzy_find = {
            previewer = false,
          },
				},
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          },
          smart_open = {
            match_algorithm = "fzf",
            disable_devicons = false,
          },
          themes = {
            enable_live_preview = true,
            persist = {
              enabled = true,
              path = vim.fn.stdpath("config") .. "/lua/helper/colorscheme.lua"
            }
          }
        },
      })
			telescope.load_extension("fzy_native")
			telescope.load_extension("themes")
			telescope.load_extension("frecency")
			telescope.load_extension("ui-select")
		end,
	},
	{
		"danielfalk/smart-open.nvim",
    enabled = false,
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
