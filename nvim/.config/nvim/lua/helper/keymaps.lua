local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.swapfile = false

keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.wo.number = true

-- search movement keeps cursor in middle
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- the greatest remap ever (Primeagen)
keymap.set("v", "<leader>p", "_dP", opts)

-- indent
keymap.set('v', '<', '<gv', opts)
keymap.set('v', '>', '>gv', opts)
-- Normal mode
keymap.set('n', '<', '<<', opts)
keymap.set('n', '>', '>>', opts)
