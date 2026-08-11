return {
  {
    -- CI/CD pipeline status in lualine
    "topaxi/pipeline.nvim",
    cmd = { "Pipeline" },
    build = "make",
    keys = {
      { "<leader>ci", "<cmd>Pipeline<cr>", desc = "CI/CD pipelines" },
    },
    opts = {
      refresh_interval = 30,
    },
  },
  {
    -- full-featured GitHub PRs + code review (inline comments, approve/merge)
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Octo" },
    keys = {
      { "<leader>go", "<cmd>Octo pr list<cr>", desc = "PR list" },
      { "<leader>goc", "<cmd>Octo pr create<cr>", desc = "Create PR" },
    },
    opts = {
      picker = "snacks",
    },
  },
  {
    -- Jira issues, sprints, agile boards, transitions
    "letieu/jira.nvim",
    cmd = { "Jira" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ji", "<cmd>Jira issues<cr>", desc = "Issues" },
      { "<leader>jb", "<cmd>Jira boards<cr>", desc = "Board" },
      { "<leader>jc", "<cmd>Jira create_issue<cr>", desc = "Create issue" },
      { "<leader>js", "<cmd>Jira search<cr>", desc = "Search" },
    },
  },
  {
    -- HTTP/GraphQL/gRPC client, JetBrains .http compatible
    "mistweaverco/kulala.nvim",
    event = { "SessionLoadPost", "VimLeavePre" },
    ft = { "http", "rest" },
    keys = {
      { "<leader>Rs", function() require("kulala").run() end, desc = "Send request" },
      { "<leader>Ra", function() require("kulala").run_all() end, desc = "Send all requests" },
      { "<leader>Rb", function() require("kulala").scratchpad() end, desc = "Open scratchpad" },
    },
    opts = {},
  },
}
