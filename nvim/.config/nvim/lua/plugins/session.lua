return {
  "olimorris/persisted.nvim",
  lazy = false,
  config = function()
    require("persisted").setup {
      autoload = true,
      autosave = true,
      use_git_branch = true,
      allowed_dirs = {
        "~/dotfiles",
        "~/Projects",
      },
    }
  end,
}
