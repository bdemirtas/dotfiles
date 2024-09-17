return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "andrew-george/telescope-themes",
      "nvim-telescope/telescope-frecency.nvim",
      "olacin/telescope-cc.nvim",
    },
    config = function()
      local builtin = require "telescope.builtin"
      local actions = require "telescope.actions"
      local action_layout = require "telescope.actions.layout"
      local map = require("helper.util").Map
      -- find
      map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      map("n", "<leader>bb", builtin.buffers, { desc = "Buffers" })
      map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "File fuzzy find" })
      map("n", "<leader>ff", builtin.find_files, { desc = "Find Files (Root Dir)" })
      map("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
      map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent" })
      -- git
      map("n", "<leader>gC", builtin.git_commits, { desc = "Commits" })
      map("n", "<leader>gc", builtin.git_bcommits, { desc = "Buffer Commits" })
      -- search
      map("n", '<leader>fG"', builtin.registers, { desc = "Registers" })
      map("n", "<leader>fc", builtin.command_history, { desc = "Command History" })
      map("n", "<leader>f/", builtin.search_history, { desc = "Commands" })
      map("n", "<leader>fD", builtin.diagnostics, { desc = "Workspace Diagnostics" })
      map("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Buffer Diagnostics" })
      map("n", "<leader>fh", builtin.help_tags, { desc = "Help Pages" })
      map("n", "<leader>fk", builtin.keymaps, { desc = "Key Maps" })
      map("n", "<leader>fM", builtin.man_pages, { desc = "Man Pages" })
      map("n", "<leader>fm", builtin.marks, { desc = "Jump to Mark" })
      map("n", "<leader>fo", builtin.vim_options, { desc = "Options" })
      map("n", "<leader>fR", builtin.resume, { desc = "Resume" })
      map("n", "<leader>ft", "<cmd>Telescope themes<CR>", { desc = "Theme Switcher" })
      map("n", "<leader>cc", "<cmd>Telescope conventional_commits<CR>", { desc = "Create conventional commit" })
      local telescope = require "telescope"
      telescope.setup {
        find_files = {
          hidden = true,
        },
        defaults = {
          prompt_title = false,
          layout_strategy = "horizontal",
          results_title = false,
          sorting_strategy = "ascending",
          file_ignore_patterns = { "node_modules", "build" },
          layout_config = {
            bottom_pane = {
              height = 20,
              preview_cutoff = 120,
              prompt_position = "top",
            },
            center = {
              height = 0.4,
              preview_cutoff = 40,
              prompt_position = "top",
              width = 0.7,
            },
            horizontal = {
              prompt_position = "top",
              preview_cutoff = 40,
              height = 0.9,
              width = 0.8,
            },
          },
          mappings = {
            i = {
              ["<c-p>"] = action_layout.toggle_preview,
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            },
            n = {
              q = actions.close,
              ["<M-p>"] = action_layout.toggle_preview,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
          },
          buffers = {
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
              },
            },
          },
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
          persisted = {
            layout_config = { width = 0.55, height = 0.55 },
          },
          smart_open = {
            match_algorithm = "fzf",
            disable_devicons = false,
          },
          conventional_commits = {
            action = function(entry)
              vim.print(entry)
            end,
            include_body_and_footer = true,
          },
          themes = {
            enable_live_preview = true,
            persist = {
              enabled = false,
              path = vim.fn.stdpath "config" .. "/lua/helper/colorscheme.lua",
            },
          },
        },
      }
      telescope.load_extension "fzy_native"
      telescope.load_extension "themes"
      telescope.load_extension "frecency"
      telescope.load_extension "ui-select"
      telescope.load_extension "projects"
      telescope.load_extension "conventional_commits"
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end,
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension "smart_open"
      vim.keymap.set("n", "<leader><leader>", function()
        require("telescope").extensions.smart_open.smart_open()
      end, { noremap = true, silent = true, desc = "Smart File Find" })
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
}
