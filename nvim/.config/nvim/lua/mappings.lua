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

-- Buffers
map("n", "<S-h>", require("nvchad.tabufline").prev, { desc = "Prev Buffer" })
map("n", "<S-l>", require("nvchad.tabufline").next, { desc = "Next Buffer" })
map("n", "<leader>x", require("nvchad.tabufline").close_buffer, { desc = "Close Buffer" })
map("n", "<leader>ba", function()
  require("nvchad.tabufline").closeAllBufs(true)
end, { desc = "Close All Buffers Exclude Current" })
map("n", "<leader>ba", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "Close All Buffers" })

-- Telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
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

vim.api.nvim_set_keymap(
  "n",
  "<leader>m",
  [[:lua PreserveAndRunMacro('q')<CR>]],
  { noremap = true, desc = "PreserveAndRunMacro" }
)

function PreserveAndRunMacro(register)
  local saved_register = vim.fn.getreg '"'
  vim.cmd("normal! @" .. register)
  vim.fn.setreg('"', saved_register)
end
