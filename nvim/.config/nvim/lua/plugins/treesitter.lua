return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "git_config",
        "csv",
        "vim",
        "python",
        "toml",
        "lua",
        "gitignore",
        "gitcommit",
        "git_rebase",
        "yaml",
        "markdown_inline",
        "norg",
      },
      ignore_install = {},
      sync_install = false,
      indent = {
        enable = true,
      },
      auto_install = true,
      highlight = { enable = true },
    }
  end,
}
