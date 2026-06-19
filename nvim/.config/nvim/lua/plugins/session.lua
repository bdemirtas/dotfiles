return {
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      need = 1,
      branch = true,
    },
    config = function(_, opts)
      require("persistence").setup(opts)

      -- persistence.nvim saves on exit but does not restore by default
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
      {
        "<leader>qs",
        function() require("persistence").load() end,
        desc = "Restore session (cwd)",
      },
      {
        "<leader>qS",
        function() require("persistence").select() end,
        desc = "Select session",
      },
      {
        "<leader>ql",
        function() require("persistence").load({ last = true }) end,
        desc = "Restore last session",
      },
      {
        "<leader>qd",
        function() require("persistence").stop() end,
        desc = "Stop session autosave",
      },
    },
  },
}