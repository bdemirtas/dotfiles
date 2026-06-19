local map = vim.keymap.set

-- ── General ────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
map("n", "<leader>qq", "<cmd>q<CR>", { desc = "Quit" })
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
-- ── Select / yank buffer ───────────────────────────────────────────────
map("n", "<leader>A", "ggVG", { desc = "Select entire buffer" })
map("n", "<leader>Y", ":%y<CR>", { desc = "Yank entire buffer" })

-- ── Paste without losing register ──────────────────────────────────────
-- Visual paste normally overwrites the yanked register with the replaced text.
-- Send the replaced text to the black-hole register so you can paste repeatedly.
map({ "x", "s" }, "p", '"_dP', { desc = "Paste without overwriting register" })
map({ "x", "s" }, "P", '"_dP', { desc = "Paste before without overwriting register" })

-- Diagnostic navigation
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show diagnostic" })
