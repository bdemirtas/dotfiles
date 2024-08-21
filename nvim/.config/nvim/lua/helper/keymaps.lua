local opts = { noremap = true, silent = true }

vim.cmd "set expandtab"
vim.cmd "set tabstop=2"
vim.cmd "set softtabstop=2"
vim.cmd "set shiftwidth=2"

vim.opt.swapfile = false

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.wo.number = true

-- search movement keeps cursor in middle
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- the greatest remap ever (Primeagen)
vim.keymap.set("v", "<leader>p", "_dP", opts)

-- indent
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
-- Normal mode
vim.keymap.set("n", "<", "<<", opts)
vim.keymap.set("n", ">", ">>", opts)

vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "X", '"_X')
vim.keymap.set({ "n", "v" }, "c", '"_c')
vim.keymap.set({ "n", "v" }, "C", '"_C')

-- quit neovim
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

vim.keymap.set("n", "<leader>z", 'mzgg"+yG`z', { desc = "Yank File" })
vim.keymap.set("n", "<leader>x", 'gg"_dG', { desc = "Delete File" })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  vim.snippet.jump(1)
end)
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  vim.snippet.jump(-1)
end)

if vim.o.wrap then
  vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], { expr = true })
  vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { expr = true })
end

vim.api.nvim_set_keymap("n", "<leader>m", [[:lua PreserveAndRunMacro('q')<CR>]], { noremap = true, desc = "PreserveAndRunMacro" })

function PreserveAndRunMacro(register)
  local saved_register = vim.fn.getreg '"'
  vim.cmd("normal! @" .. register)
  vim.fn.setreg('"', saved_register)
end
