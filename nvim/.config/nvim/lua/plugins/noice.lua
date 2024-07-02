return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = false,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
          command_palette = {
            views = {
              cmdline_popup = {
                position = {
                  row = "50%",
                  col = "50%",
                },
                size = {
                  min_width = 60,
                  width = "auto",
                  height = "auto",
                },
              },
              -- uncomment lines below if not used nvim-cmp as backend
              cmdline_popupmenu = {
                position = {
                  row = "80%",
                  col = "50%",
                },
              },
            },
          },
        },
          })
        end,
    },
}
