return {
  {
    "fredeeb/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      { "<leader>gt", "<cmd>Tardis<cr>", desc = "Time Machine" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        on_attach = function(bufnr)
          local gitsigns = require "gitsigns"

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal { "]c", bang = true }
            else
              gitsigns.nav_hunk "next"
            end
          end)

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal { "[c", bang = true }
            else
              gitsigns.nav_hunk "prev"
            end
          end)

          -- Actions
          map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
          map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
          map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>gB", function()
            gitsigns.blame_line { full = true }
          end, { desc = "Open git blame panel" })
          map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "Enter line blame mode" })
          map("n", "<leader>gD", gitsigns.diffthis, { desc = "Open diff" })
          map("n", "<leader>gd", gitsigns.toggle_deleted, { desc = "Toggle deleted line" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        end,
      }
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("neogit").setup {
        vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" }),
      }
    end,
  },
}
