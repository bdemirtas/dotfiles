return {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require("which-key")

    wk.add({
      {"<leader>e", "<cmd>Neotree filesystem reveal left<cr>", desc="Neotree toggle"},
      { "<leader>c", group = "Code" },
      { "<leader>b", group = "Buffers", expand = function()
        return require("which-key.extras").expand.buf()
      end,
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>n", group = "Noice" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Terminal" },
      { "<leader>w", group = "Workspace" },
      { "<leader>u", group = "UI" },
      },
      {
        mode = { "n", "v" },
        { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
      }
    })
  end,
}
