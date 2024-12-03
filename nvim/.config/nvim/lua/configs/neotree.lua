local options = {}

options = {
  enable_git_status = true,
  enable_diagnostics = true,
  filesystem = {
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_hidden = false,
      hide_by_name = {
        "node_modules",
      },
      hide_by_pattern = { -- uses glob style patterns
        "*.meta",
        "*/src/*/tsconfig.json",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        ".gitignored",
      },
      always_show_by_pattern = { -- uses glob style patterns
        ".env*",
        ".venv",
        "venv",
        "env",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        ".DS_Store",
        "thumbs.db",
      },
      never_show_by_pattern = { -- uses glob style patterns
        ".null-ls_*",
        "__pycache__",
        "*.pyc",
      },
    },
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --               -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- "open_current",  -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
    commands = {}, -- Add a custom command or override a global one using the same function name
  },
  buffers = {
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --              -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = true, -- when true, empty folders will be grouped together
    show_unloaded = true,
  },
  icon = {
    folder_closed = "",
    folder_open = "",
    folder_empty = "󰜌",
    default = "*",
    highlight = "NeoTreeFileIcon",
  },
  git_status = {
    symbols = {
      -- Change type
      added = "✚",
      deleted = "✖",
      modified = "",
      renamed = "",
      -- Status type
      untracked = "",
      ignored = "",
      unstaged = "",
      staged = "",
      conflict = "",
    },
  },
}


return options
