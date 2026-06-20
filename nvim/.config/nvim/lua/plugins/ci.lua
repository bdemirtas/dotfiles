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
}