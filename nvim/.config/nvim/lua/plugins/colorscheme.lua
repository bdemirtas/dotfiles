return {
  {
    "nvim-mini/mini.hues",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      -- Bundled schemes (no setup needed):
      --   miniwinter  – icy azure
      --   minispring  – green
      --   minisummer  – warm brown/yellow
      --   miniautumn  – purple
      --   randomhue   – random hue each time
      --
      -- Or generate a custom palette:
      -- require("mini.hues").setup({
      --   background = "#19213a",
      --   foreground = "#c4c6cd",
      --   n_hues = 8,
      --   saturation = "medium", -- low | lowmedium | medium | mediumhigh | high
      --   accent = "azure",      -- bg | fg | red | orange | yellow | green | cyan | azure | blue | purple
      -- })
      --
      -- Switch anytime with :colorscheme minispring  or  <leader>uC
      vim.cmd.colorscheme("miniautumn")
    end,
  },
  -- Kept so you can switch back via <leader>uC
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
  },
}
