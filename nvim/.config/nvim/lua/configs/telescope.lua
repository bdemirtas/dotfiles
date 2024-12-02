local options = {
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
        ["<c-p>"] = require("telescope.actions.layout").toggle_preview,
        ["<c-j>"] = require("telescope.actions").move_selection_next,
        ["<c-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
        ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
      },
      n = {
        q = require("telescope.actions").close,
        ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
      },
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer + require("telescope.actions").move_to_top,
        },
      },
    },
    current_buffer_fuzzy_find = {
      previewer = false,
    },
  },
}

return options
