return {
  "stevearc/dressing.nvim",
  enable = true,
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
