-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function() vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 }) end,
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

-- Close certain filetypes with just q and keep them unlisted
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
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
  callback = function(ev)
    local buf = ev.buf
    local function map(mode, lhs, rhs, desc, opts)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { buffer = buf, silent = true, desc = desc }, opts or {}))
    end

    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gO", vim.lsp.buf.document_symbol, "Document symbols")
    map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
    map(
      "n",
      "<leader>cr",
      vim.lsp.buf.rename,
      "Rename symbol"
    )
    map(
      "n",
      "<leader>ca",
      function() require("tiny-code-action").code_action() end,
      "Code action",
      { noremap = true, silent = true }
    )
    map("n", "<leader>cI", vim.lsp.buf.incoming_calls, "Incoming calls")
    map("n", "<leader>cO", vim.lsp.buf.outgoing_calls, "Outgoing calls")
    map("n", "K", vim.lsp.buf.hover, "Hover docs")
    map("x", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map(
      "n",
      "<leader>wl",
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      "List workspace folders"
    )
  end,
})
