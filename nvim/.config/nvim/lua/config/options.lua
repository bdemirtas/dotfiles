local opt = vim.opt

-- UI
vim.g.have_nerd_font = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false
opt.winborder = "single"

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Behaviour
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 200
opt.timeoutlen = 300
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Wrapping
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- Completion
opt.completeopt = { "menuone", "noselect" }

-- Diagnostics
vim.diagnostic.config({
  virtual_text = { prefix = "" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  float = { prefix = "", header = "", severity_sort = true, source = true },
})

-- Disable inlay hints globally
vim.lsp.inlay_hint.enable(false)
