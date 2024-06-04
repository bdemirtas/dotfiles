return {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    vim.keymap.set("v", "<Leader>?", "<Esc>:WhichKey '' v<CR>", { silent = true })
    vim.keymap.set("n", "<Leader>?", "<Esc>:WhichKey '' n<CR>", { silent = true, desc = "which-key root" })

    vim.cmd([[highlight default link WhichKey          Label]])
    vim.cmd([[highlight default link WhichKeySeperator String]])
    vim.cmd([[highlight default link WhichKeyGroup     Include]])
    vim.cmd([[highlight default link WhichKeyDesc      Function]])
    vim.cmd([[highlight default link WhichKeyFloat     CursorLine]])
    vim.cmd([[highlight default link WhichKeyValue     Comment]])

    local wk = require("which-key")
    local opts = {
      mode = { "n", "v" },
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    }

    local keymaps = {
      ["<leader>"] = {
        ["?"] = "which-key root",
        ["<space>"] = "toggle relative line numbers",
        ["e"] = { ":Neotree filesystem reveal left<CR>", "Neotree toggle" },
        ["b"] = { name = "Debugging" },
        ["c"] = { name = "Code" },
        ["f"] = { name = "Find" },
        ["d"] = { name = "Delete/Close" },
        ["g"] = { name = "Git" },
        ["o"] = { name = "Org"},
        ["s"] = { name = "Search" },
        ["t"] = { name = "Terminal" },
        ["w"] = { name = "Workspace" },
        ["u"] = { name = "UI" },
      },
    }

    wk.register(keymaps, opts)
  end,
}
