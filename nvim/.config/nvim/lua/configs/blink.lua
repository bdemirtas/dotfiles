local options = {}

options = {
  completion = {
    keyword = { range = "full" },
    trigger = {
      show_on_keyword = true,
    },
    menu = {
      -- nvim-cmp style menu
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" },
        },
      },
    },
    -- Show documentation when selecting a completion item
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    -- Display a preview of the selected item on the current line
    ghost_text = { enabled = false },
  },
  sources = {
    -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
    default = { "lsp", "path", "snippets", "buffer" },
    -- Disable cmdline completions
    cmdline = {},
  },
  -- Use a preset for snippets, check the snippets documentation for more information
  snippets = { preset = "luasnip" },
  -- Experimental signature help support
  signature = { enabled = true },
  keymap = {
    preset = "enter",
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-l>"] = { "show_signature", "hide_signature", "fallback" },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
}

return options
