return {
  "gbprod/yanky.nvim",
  opts = function()
    local mapping = require "yanky.telescope.mapping"
    local mappings = mapping.get_defaults()
    mappings.i["<c-p>"] = nil
    return {
      highlight = { timer = 200 },
      picker = {
        telescope = {
          use_default_mappings = false,
          mappings = mappings,
        },
      },
    }
  end,
  keys = {
    {
      "y",
      "<Plug>(YankyYank)",
      mode = { "n", "x" },
      desc = "Yank text",
    },
    {
      "p",
      "<Plug>(YankyPutAfter)",
      mode = { "n", "x" },
      desc = "Put yanked text after cursor",
    },
    {
      "P",
      "<Plug>(YankyPutBefore)",
      mode = { "n", "x" },
      desc = "Put yanked text before cursor",
    },
  },
}
