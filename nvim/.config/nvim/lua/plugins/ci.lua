local function current_repo_view(domain, kind)
  return function()
    local info = require("atlas.core.git").local_repository(vim.fn.expand("%:p:h"))
    local configured = info and vim.tbl_get(require("atlas.config").options, domain, "providers", info.provider) ~= nil

    if not configured then
      vim.cmd("Atlas " .. domain)
      return
    end

    require("atlas").open(domain, info.provider, {
      initial_view = {
        name = info.slug,
        search = string.format("repo:%s is:%s is:open", info.slug, kind),
      },
    })
  end
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
    -- Atlas only registers `:Atlas <subcommand>` and `:AtlasDiff`.
    cmd = { "Atlas", "AtlasDiff" },
    keys = {
      { "<leader>ap", "<cmd>Atlas pulls<cr>", desc = "Pull requests" },
      { "<leader>ai", "<cmd>Atlas issues<cr>", desc = "Issues" },
      { "<leader>ac", "<cmd>Atlas create pr<cr>", desc = "Create PR" },
      { "<leader>aC", "<cmd>Atlas create issue<cr>", desc = "Create issue" },
      { "<leader>as", "<cmd>Atlas search<cr>", desc = "Search" },
      { "<leader>an", "<cmd>Atlas notes<cr>", desc = "Review notes" },
      { "<leader>aP", current_repo_view("pulls", "pr"), desc = "PRs (this repo)" },
      { "<leader>aI", current_repo_view("issues", "issue"), desc = "Issues (this repo)" },
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
