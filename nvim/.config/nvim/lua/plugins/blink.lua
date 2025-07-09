return {
  "saghen/blink.cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    "rafamadriz/friendly-snippets",
  },
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = function()
    return require "config.blink"
  end,
  opts_extend = { "sources.default" },
}
