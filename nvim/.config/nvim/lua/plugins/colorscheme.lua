return {
  {
    -- catppuccin mocha with pure black background
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require("catppuccin").setup(vim.tbl_deep_extend("force", {
        no_italic = true,
        transparent_background = false,
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        },
        integrations = {
          gitsigns = true,
          neogit = true,
          treesitter = true,
          which_key = true,
          blink_cmp = true,
          native_lsp = { enabled = true, inlay_hints = { background = true } },
        },
      }, opts))
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    -- backup colorscheme
    "scottmckendry/cyberdream.nvim",
    lazy = true,
  },
}
