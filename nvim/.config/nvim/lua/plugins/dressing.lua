return {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      start_in_insert = false,
      insert_only = false,
    },
    select = {
      telescope = require("telescope.themes").get_cursor {
        layout_config = {
          preview_height = nil,
        },
      },
    },
  },
}
