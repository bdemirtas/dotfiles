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
map({ "n" }, "<C-k>", function()
  require("lsp_signature").toggle_float_win()
end, { desc = "toggle signature" })

-- Conform
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format {
    lsp_fallback = true,
    async = true,
    timeout_ms = 5000,
  }
end, { desc = "Format buffer" })

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


-- stylua: ignore start
vim.keymap.set("n", "<leader>z",    function() Snacks.zen() end,                     { desc = "Toggle Zen Mode" })
vim.keymap.set("n", "<leader>Z",    function() Snacks.zen.zoom() end,                { desc = "Toggle Zoom" })
vim.keymap.set("n", "<leader>.",    function() Snacks.scratch() end,                 { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S",    function() Snacks.scratch.select() end,          { desc = "Select Scratch Buffer" })
vim.keymap.set("n", "<leader>nn",   function() Snacks.notifier.show_history() end,   { desc = "Notification History" })
vim.keymap.set("n", "<leader>un",   function() Snacks.notifier.hide() end,           { desc = "Dismiss All Notifications" })
vim.keymap.set("n", "<leader>bd",   function() Snacks.bufdelete() end,               { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>x",   function() Snacks.bufdelete() end,               { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>gb",   function() Snacks.git.blame_line() end,          { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gB",   function() Snacks.gitbrowse() end,               { desc = "Git Browse" })
vim.keymap.set("n", "<leader>cr",   function() Snacks.rename() end,                  { desc = "Rename File" })
vim.keymap.set("n", "<leader>ps",   function() Snacks.profiler.scratch() end,        { desc = "Profiler Scratch Buffer" })
vim.keymap.set({"n", "t"}, "<c-,>", function() Snacks.terminal.toggle() end,         { desc = "Toggle Terminal" })
vim.keymap.set({ "n", "t" }, "]]",  function() Snacks.words.jump(vim.v.count1) end,  { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "[[",  function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
-- stylua: ignore end
