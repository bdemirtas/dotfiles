local map = vim.keymap.set

-- ── General ────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>W", "<cmd>wa<CR>", { desc = "Save all" })

-- ── Navigation ─────────────────────────────────────────────────────────
-- Centered scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Better j/k on wrapped lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Window navigation (works with smart-splits if added later)
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Window resize
map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- ── Buffers ────────────────────────────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>%bdelete|edit#|bdelete#<CR>", { desc = "Delete other buffers" })

-- ── Indenting ──────────────────────────────────────────────────────────
map({ "v", "n" }, "<Tab>", ">gv", { desc = "Indent" })
map({ "v", "n" }, "<S-Tab>", "<gv", { desc = "Unindent" })

-- ── Moving lines ───────────────────────────────────────────────────────
-- Visual mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move line up" })

-- Normal mode
map("n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true, desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true, desc = "Move line up" })
-- ── Paste without losing register ──────────────────────────────────────
map("v", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Diagnostic navigation
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show diagnostic" })
