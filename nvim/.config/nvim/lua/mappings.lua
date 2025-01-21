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

-- Fzf
map("n", "<leader>fw", require("fzf-lua").live_grep, { desc = "Fzf live grep" })
map("n", "<leader>fb", require("fzf-lua").buffers, { desc = "Fzf find buffers" })
map("n", "<leader>fh", require("fzf-lua").helptags, { desc = "Fzf help page" })
map("n", "<leader>fo", require("fzf-lua").oldfiles, { desc = "Fzf find oldfiles" })
map("n", "<leader>fz", require("fzf-lua").grep_curbuf, { desc = "Fzf find in current buffer" })
map("n", "<leader>gm", require("fzf-lua").git_commits, { desc = "Fzf git commits" })
map("n", "<leader>gt", require("fzf-lua").git_status, { desc = "Fzf git status" })
map("n", "<leader>ff", require("fzf-lua").files, { desc = "Fzf find files" })
map(
  "n",
  "<leader>fa",
  function() require("fzf-lua").files({ cmd = "fd --color=never --type f --hidden --follow --exclude .git"}) end,
  { desc = "Fzf find all files" }
)
map("n", "<leader>fD", require("fzf-lua").diagnostics_workspace, { desc = "Workspace Diagnostics" })
map("n", "<leader>fd", require("fzf-lua").diagnostics_document, { desc = "Buffer Diagnostics" })
map("n", "<leader>fk", require("fzf-lua").keymaps, { desc = "Key Maps" })
map("n", "<leader>fM", require("fzf-lua").manpages, { desc = "Man Pages" })
map("n", "<leader>fm", require("fzf-lua").marks, { desc = "Jump to Mark" })

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

-- stylua: ignore start
vim.keymap.set("n", "<leader>z",    function() Snacks.zen() end,                     { desc = "Toggle Zen Mode" })
vim.keymap.set("n", "<leader>Z",    function() Snacks.zen.zoom() end,                { desc = "Toggle Zoom" })
vim.keymap.set("n", "<leader>.",    function() Snacks.scratch() end,                 { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S",    function() Snacks.scratch.select() end,          { desc = "Select Scratch Buffer" })
vim.keymap.set("n", "<leader>nn",   function() Snacks.notifier.show_history() end,   { desc = "Notification History" })
vim.keymap.set("n", "<leader>un",   function() Snacks.notifier.hide() end,           { desc = "Dismiss All Notifications" })
-- vim.keymap.set("n", "<leader>bd",   function() Snacks.bufdelete() end,               { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>gb",   function() Snacks.git.blame_line() end,          { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gB",   function() Snacks.gitbrowse() end,               { desc = "Git Browse" })
vim.keymap.set("n", "<leader>cr",   function() Snacks.rename() end,                  { desc = "Rename File" })
vim.keymap.set("n", "<leader>ps",   function() Snacks.profiler.scratch() end,        { desc = "Profiler Scratch Buffer" })
vim.keymap.set({"n", "t"}, "<c-,>", function() Snacks.terminal.toggle() end,         { desc = "Toggle Terminal" })
vim.keymap.set({ "n", "t" }, "]]",  function() Snacks.words.jump(vim.v.count1) end,  { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "[[",  function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
-- stylua: ignore end
