local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Move selected line / block of text in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- the greatest remap ever (Primeagen)
map("v", "<leader>p", "_dP", opts)

-- indent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Normal mode
map("n", "<", "<<", opts)
map("n", ">", ">>", opts)

-- quit neovim
map("n", "<leader>q", vim.cmd.Ex)

-- Conform
map({ "n", "v" }, "<leader>cf", function()
  require("conform").format {
    lsp_fallback = true,
    async = true,
    timeout_ms = 5000,
  }
end, { desc = "Format buffer" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
