-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 }) end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("trim_whitespace", { clear = true }),
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Resize splits on terminal resize
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  callback = function() vim.cmd("tabdo wincmd =") end,
})

-- Close certain filetypes with just q
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = { "help", "lspinfo", "lazy", "mason", "checkhealth", "qf" },
  callback = function(ev) vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true }) end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
  callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "grug-far",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
