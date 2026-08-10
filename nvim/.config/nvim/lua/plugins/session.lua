return {
  {
    -- auto-detect indent settings per file
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    -- session restore: remembers open files and layout
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      need = 1,
      branch = true,
    },
    config = function(_, opts)
      require("persistence").setup(opts)
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("persistence_auto", { clear = true }),
        callback = function()
          if vim.fn.argc() > 0 then
            return
          end
          vim.schedule(function()
            require("persistence").load({ last = true })
          end)
        end,
      })
    end,
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore session (cwd)" },
      { "<leader>qS", function() require("persistence").select() end, desc = "Select session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Stop session autosave" },
    },
  },
  {
    -- Obsidian vault: [[wiki-links]], daily notes, backlinks, tags
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>Nt", "<cmd>Obsidian today<cr>", desc = "Today note" },
      { "<leader>Nn", "<cmd>Obsidian new<cr>", desc = "New note" },
      { "<leader>Ns", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch" },
    },
    opts = {
      workspaces = {
        { name = "personal", path = "~/vaults/personal" },
      },
      picker = { name = "snacks.picker" },
    },
  },
}
