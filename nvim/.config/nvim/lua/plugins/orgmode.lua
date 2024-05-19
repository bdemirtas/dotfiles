return {
	{
		"akinsho/org-bullets.nvim",
		config = function()
			require("org-bullets").setup({})
		end,
	},
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			require("orgmode").setup({
				org_agenda_files = "~/orgfiles/**/*",
				org_default_notes_file = "~/orgfiles/notes.org",
				mappings = {
					agenda = {
						org_agenda_later = ">",
						org_agenda_earlier = "<",
						org_agenda_goto_today = { ".", "T" },
					},
					global = {
						org_agenda = "<leader>oa",
						org_capture = "<leader>oc",
					},
				},
			})
		end,
	},
}
