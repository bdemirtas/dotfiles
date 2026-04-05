return {
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "uv.lock", ".git" },
  cmd = { "basedpyright-langserver", "--stdio" },
  settings = {
    python = { ignore = { "*" } },
    basedpyright = {
      analysis = {
        inlayHints = { callArgumentNames = true },
        extraPaths = { ".", "./src" },
        autoSearchPaths = true,
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = false,
        allowedUntypedLibraries = true,
        diagnosticMode = "openFilesOnly",
        diagnosticSeverityOverrides = {
          reportGeneralTypeIssues = false,
          reportOptionalMemberAccess = false,
          reportOptionalSubscript = false,
          reportPrivateImportUsage = false,
          reportUnusedExpression = false,
        },
      },
    },
  },
}
