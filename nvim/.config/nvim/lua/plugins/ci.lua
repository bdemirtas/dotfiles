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
    -- PRs (GitHub/Bitbucket/GitLab) + issues (Jira/GitHub/GitLab) in one tool
    "emrearmagan/atlas.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
      "AtlasPulls",
      "AtlasIssues",
      "AtlasCreatePR",
      "AtlasCreateIssue",
      "AtlasSearch",
      "AtlasDiff",
      "AtlasNotes",
      "AtlasOpen",
      "AtlasClearCache",
      "AtlasLogs",
    },
    keys = {
      { "<leader>ap", "<cmd>AtlasPulls<cr>", desc = "Pull requests" },
      { "<leader>ai", "<cmd>AtlasIssues<cr>", desc = "Issues" },
      { "<leader>ac", "<cmd>AtlasCreatePR<cr>", desc = "Create PR" },
      { "<leader>aC", "<cmd>AtlasCreateIssue<cr>", desc = "Create issue" },
      { "<leader>as", "<cmd>AtlasSearch<cr>", desc = "Search" },
      { "<leader>an", "<cmd>AtlasNotes<cr>", desc = "Review notes" },
    },
    opts = {
      pulls = {
        diff = { open_cmd = "CodeDiff" },
        repo_config = {
          paths = { ["*/*"] = vim.fn.expand("~") .. "/Projects/*" },
        },
        providers = {
          github = {
            views = {
              { name = "Mine", key = "1", layout = "compact", search = "is:pr is:open author:@me sort:updated-desc" },
              { name = "Review", key = "2", layout = "compact", search = "is:pr is:open review-requested:@me" },
            },
            bookmarks = {
              items = {
                ["Drafts"] = "is:pr is:draft author:@me",
                ["Recently merged"] = "is:pr is:merged author:@me sort:updated-desc",
              },
            },
          },
        },
      },
      issues = {
        providers = {
          github = {
            views = {
              { name = "Assigned", key = "1", layout = "plain", search = "is:issue is:open assignee:@me" },
              { name = "Created", key = "2", layout = "plain", search = "is:issue is:open author:@me" },
            },
          },
        },
      },
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
