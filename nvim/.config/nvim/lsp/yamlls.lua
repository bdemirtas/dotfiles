return {
  filetypes = { "yaml", "yml" },
  cmd = { "yaml-language-server", "--stdio" },
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas({
        extra = {
          {
            name = "Databricks Asset Bundles",
            url = "https://json.schemastore.org/databricks-asset-bundles.json",
            fileMatch = { ".databricks.yml", ".databricks.yaml" },
          },
        },
      }),
    },
  },
}
