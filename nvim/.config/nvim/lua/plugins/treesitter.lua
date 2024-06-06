return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "json",
        "luadoc",
        "bash",
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
        "sql",
        "markdown",
        "markdown_inline",
        "regex",
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
