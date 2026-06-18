---@type vim.lsp.Config
return {
  cmd = { "pyrefly", "lsp" },
  filetypes = { "python" },
  root_markers = { "pyrefly.toml", "pyproject.toml", "setup.py", "uv.lock", ".git" },
  settings = {
    pyrefly = {
      typeCheckingMode = "basic",
      diagnosticMode = "openFilesOnly",
      analysis = {
        inlayHints = {
          callArgumentNames = "all",
        },
      },
    },
  },
}
