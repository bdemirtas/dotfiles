local function atlas_opts(_, opts)
  local base = {
    pulls = {
      diff = { open_cmd = "CodeDiff" },
      repo_config = {
        paths = { ["*/*"] = vim.fn.expand("~") .. "/Projects/*" },
      },
      providers = {
        github = {
          views = {
            { name = "Mine", key = "1", layout = "compact", search = "is:pr is:open author:@me sort:updated-desc" },
            {
              name = "Review",
              key = "2",
              layout = "compact",
              search = "is:pr is:open review-requested:@me sort:updated-desc",
            },
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
  }

  -- Jira only exists on the work laptop; skip the provider entirely when unset.
  if vim.env.JIRA_URL and vim.env.JIRA_EMAIL and vim.env.JIRA_TOKEN then
    base.issues.providers.jira = {
      base_url = vim.env.JIRA_URL,
      email = vim.env.JIRA_EMAIL,
      token = vim.env.JIRA_TOKEN,
      api_type = "cloud", -- "server" for on-prem Jira (REST v2)
    }
  end

  return vim.tbl_deep_extend("force", base, opts or {})
end

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
    opts = atlas_opts,
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
