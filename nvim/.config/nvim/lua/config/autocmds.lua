-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 150 }
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("trim_whitespace", { clear = true }),
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[%s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Resize splits on terminal resize
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- Close certain filetypes with just q
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = { "help", "lspinfo", "lazy", "mason", "checkhealth", "qf" },
  callback = function(ev)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- vim.api.nvim_create_autocmd("LspProgress", {
--   callback = function(ev)
--     vim.print(ev.data)
--     local value = ev.data.params.value
--     vim.api.nvim_echo({ { value.message or "done" } }, false, {
--       id = "lsp." .. ev.data.client_id,
--       kind = "progress",
--       source = "vim.lsp",
--       title = value.title,
--       status = value.kind ~= "end" and "running" or "success",
--       percent = value.percentage,
--     })
--   end,
-- })
