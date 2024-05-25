return {
  {
    "fredeeb/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      { "<leader>gt", "<cmd>Tardis<cr>", desc = "Time Machine" },
    }
  },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end)

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end)

					-- Actions
					map("n", "]g", gitsigns.stage_hunk, { desc = "Next Git hunk" })
          map("n", "[g", gitsigns.reset_hunk, { desc = "Previous Git hub" })
          -- map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage Git buffer" })
          map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Unstage Git hunk" })
          map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset Git buffer" })
					map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview Git hunk" })
					map("n", "<leader>gL", function()
						gitsigns.blame_line({ full = true })
					end, { desc = "View Full Git blame" })
					map("n", "<leader>gl", gitsigns.toggle_current_line_blame, { desc = "View Git blame" })
					map("n", "<leader>gd", gitsigns.diffthis, { desc = "View Git diff" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"ibhagwan/fzf-lua", -- optional
		},
		config = function()
			require("neogit").setup({
				vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" }),
			})
		end,
	},
}
