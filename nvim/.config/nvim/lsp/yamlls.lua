return {
  filetypes = { "yaml", "yml" },
  cmd = { "yaml-language-server", "--stdio" },
  settings = {
    yaml = {
      schemas = {
        ["http://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
        ["http://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/gitlab-ci.json"] = "/*lab-ci.{yml,yaml}",
        ["https://json.schemastore.org/databricks-asset-bundles.json"] = ".databricks.{yml,yaml}",
      },
    },
  },
}
