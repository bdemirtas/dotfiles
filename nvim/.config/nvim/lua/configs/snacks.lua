local options = {}

---@type snacks.Config
options = {
  scroll = {},
  rename = {
    enable = true,
  },
  notifier = {
    border = "rounded",
    zindex = 100,
    ft = "markdown",
    wo = {
      winblend = 5,
      wrap = false,
      conceallevel = 2,
      colorcolumn = "",
    },
    bo = { filetype = "snacks_notif" },
  },
  picker = {
    layout = {
      preset = "telescope",
    },
  },
  explorer = {},
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  gitbrowse = { enabled = true },
  statuscolumn = { enabled = false },
  words = { enabled = false },
  input = {
    icon = " ",
    icon_hl = "SnacksInputIcon",
    icon_pos = "left",
    prompt_pos = "title",
    win = { style = "input" },
    expand = true,
  },
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
  -- notifier = {
  --   enabled = true,
  --   timeout = 3000,
  --   style = "fancy",
  -- },
  blank = {
    char = " ",
    -- char = "·",
    hl = "SnacksIndentBlank", ---@type string|string[] hl group for blank spaces
  },
  dashboard = {
    sections = {
      { section = "header" },
      {
        pane = 2,
        section = "terminal",
        cmd = "colorscript -e dna",
        height = 5,
        padding = 1,
      },
      { section = "keys", gap = 1, padding = 1 },
      {
        pane = 2,
        icon = " ",
        desc = "Browse Repo",
        padding = 1,
        key = "b",
        action = function()
          Snacks.gitbrowse()
        end,
      },
      function()
        local in_git = Snacks.git.get_root() ~= nil
        local cmds = {
          {
            title = "Notifications",
            cmd = "gh notify -s -a -n5",
            action = function()
              vim.ui.open "https://github.com/notifications"
            end,
            key = "n",
            icon = " ",
            height = 5,
            enabled = true,
          },
          {
            title = "Open Issues",
            cmd = "gh issue list -L 3",
            key = "i",
            action = function()
              vim.fn.jobstart("gh issue list --web", { detach = true })
            end,
            icon = " ",
            height = 7,
          },
          {
            icon = " ",
            title = "Open PRs",
            cmd = "gh pr list -L 3",
            key = "P",
            action = function()
              vim.fn.jobstart("gh pr list --web", { detach = true })
            end,
            height = 7,
          },
          {
            icon = " ",
            title = "Git Status",
            cmd = "git --no-pager diff --stat -B -M -C",
            height = 10,
          },
        }
        return vim.tbl_map(function(cmd)
          return vim.tbl_extend("force", {
            pane = 2,
            section = "terminal",
            enabled = in_git,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          }, cmd)
        end, cmds)
      end,
      { section = "startup" },
    },
  },
}

return options
