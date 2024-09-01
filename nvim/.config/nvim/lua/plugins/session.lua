return {
  "olimorris/persisted.nvim",
  lazy = false,
  config = function()
    require("persisted").setup {
      use_git_branch = true,
      allowed_dirs = {
        "~/dotfiles",
        "~/Projects",
      },
    }
  end,
}
