local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.cmd "set expandtab"
vim.cmd "set tabstop=2"
vim.cmd "set softtabstop=2"
vim.cmd "set shiftwidth=2"

vim.opt.swapfile = false

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })
vim.wo.number = true

-- search movement keeps cursor in middle
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- the greatest remap ever (Primeagen)
map("v", "<leader>p", "_dP", opts)

-- indent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- Normal mode
map("n", "<", "<<", opts)
map("n", ">", ">>", opts)

map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "X", '"_X')
map({ "n", "v" }, "c", '"_c')
map({ "n", "v" }, "C", '"_C')

-- quit neovim
map("n", "<leader>q", vim.cmd.Ex)

map("n", "<leader>z", 'mzgg"+yG`z', { desc = "Yank File" })
map("n", "<leader>x", 'gg"_dG', { desc = "Delete File" })

map({ "i", "s" }, "<C-j>", function()
  vim.snippet.jump(1)
end)
map({ "i", "s" }, "<C-k>", function()
  vim.snippet.jump(-1)
end)

if vim.o.wrap then
  map("n", "j", [[v:count ? 'j' : 'gj']], { expr = true })
  map("n", "k", [[v:count ? 'k' : 'gk']], { expr = true })
end

-- tabufline
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>gm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>ft", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
map("n", "<leader>fD", "<cmd>Telescope diagnostics<CR>", { desc = "Workspace Diagnostics" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Buffer Diagnostics" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Key Maps" })
map("n", "<leader>fM", "<cmd>Telescope man_pages<CR>", { desc = "Man Pages" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Jump to Mark" })
map("n", "<leader>fv", "<cmd>Telescope vim_options<CR>", { desc = "Options" })

-- Conform
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format {
    lsp_fallback = true,
    async = true,
    timeout_ms = 5000,
  }
end, { desc = "Format buffer" })

-- Noice
map("n", "<leader>nl", ":Noice last<cr>", { desc = "Last" })
map("n", "<leader>nh", ":Noice history<cr>", { desc = "History" })
map("n", "<leader>nc", ":Noice dismiss<cr>", { desc = "Dismiss" })
map("n", "<leader>ne", ":Noice errors<cr>", { desc = "Errors" })
map("n", "<leader>nt", ":Noice telescope<cr>", { desc = "Telescope" })

-- Smart Split
map("n", "<C-k>", function()
  require("smart-splits").move_cursor_up()
end, { desc = "Move to left split" })
map("n", "<C-j>", function()
  require("smart-splits").move_cursor_down()
end, { desc = "Move to below split" })
map("n", "<C-h>", function()
  require("smart-splits").move_cursor_left()
end, { desc = "Move to above split" })
map("n", "<C-l>", function()
  require("smart-splits").move_cursor_right()
end, { desc = "Move to right split" })

-- Trouble
map("n", "<leader>wx", "<cmd>Trouble<CR>", { desc = "Open/close trouble list" })
map(
  "n",
  "<leader>wd",
  "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
  { desc = "Open trouble document diagnostics" }
)
map(
  "n",
  "<leader>cl",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "LSP Definitions / references / ... (Trouble)" }
)

-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>m",
--   [[:lua PreserveAndRunMacro('q')<CR>]],
--   { noremap = true, desc = "PreserveAndRunMacro" }
-- )
--
-- function PreserveAndRunMacro(register)
--   local saved_register = vim.fn.getreg '"'
--   vim.cmd("normal! @" .. register)
--   vim.fn.setreg('"', saved_register)
-- end
