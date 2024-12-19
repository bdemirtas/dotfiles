return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    gitbrowse = { enabled = true },
    dashboard = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    input = { enabled = true },
    indent = {
      priority = 1,
      enabled = true, -- enable indent guides
      char = "│",
      blank = nil, ---@type string? blank space character. If nil, it will use listchars when list is enabled.
      only_scope = false, -- only show indent guides of the scope
      only_current = false, -- only show indent guides in the current window
      hl = {
          "SnacksIndent1",
          "SnacksIndent2",
          "SnacksIndent3",
          "SnacksIndent4",
          "SnacksIndent5",
          "SnacksIndent6",
          "SnacksIndent7",
          "SnacksIndent8",
      },
    },
    scope = {
      enabled = true, -- enable highlighting the current scope
      priority = 200,
      char = "│",
      underline = false, -- underline the start of the scope
      only_current = false, -- only show scope in the current window
      hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
    },
    chunk = {
      -- when enabled, scopes will be rendered as chunks, except for the
      -- top-level scope which will be rendered as a scope.
      enabled = false,
      -- only show chunk scopes in the current window
      only_current = false,
      priority = 200,
      hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
      char = {
        corner_top = "┌",
        corner_bottom = "└",
        horizontal = "─",
        vertical = "│",
        arrow = ">",
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
      style = "fancy",
    },
    blank = {
      char = " ",
      -- char = "·",
      hl = "SnacksIndentBlank", ---@type string|string[] hl group for blank spaces
    },
  },
}
