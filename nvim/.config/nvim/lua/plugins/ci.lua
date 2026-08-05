return {
  {
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
    "emrearmagan/atlas.nvim",
    cmd = {
      "AtlasPulls",
      "AtlasIssues",
      "AtlasDiff",
      "AtlasCreatePR",
      "AtlasCreateIssue",
      "AtlasSearch",
      "AtlasOpen",
      "AtlasNotes",
    },
    dependencies = {
      "esmuellert/codediff.nvim",
      "nvim-tree/nvim-web-devicons",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    keys = {
      { "<leader>ap", "<cmd>AtlasPulls github<cr>", desc = "Pull requests" },
      { "<leader>ai", "<cmd>AtlasIssues jira<cr>", desc = "Issues" },
      { "<leader>ac", "<cmd>AtlasCreatePR<cr>", desc = "Create PR" },
      { "<leader>aC", "<cmd>AtlasCreateIssue<cr>", desc = "Create issue" },
      { "<leader>an", "<cmd>AtlasNotes<cr>", desc = "Review notes" },
      { "<leader>as", "<cmd>AtlasSearch jira<cr>", desc = "Search" },
    },
    opts = {
      pulls = {
        providers = { github = {} },
      },
      issues = {
        providers = {
          jira = {
            base_url = "https://your-site.atlassian.net",
            email = "you@example.com",
            token = vim.env.JIRA_TOKEN or "",
          },
        },
      },
      keymaps = {
        pulls = {
          open_diff = "gD",
          checkout = "gC",
          review = {
            add_note = "gn",
            add_pending_comment = "gq",
            request_changes = "gX",
          },
        },
      },
    },
  },
}