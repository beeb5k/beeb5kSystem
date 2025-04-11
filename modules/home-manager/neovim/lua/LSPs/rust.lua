return {
  "rust_analyzer",
  lsp = {
    filetypes = { "rust" },
    settings = {
      ["rust-analyzer"] = {
        inlayHints = {
          enable = true,
          bindingModeHints = { enable = true },
          chainingHints = { enable = true },
          closingBraceHints = { enable = true },
          closureCaptureHints = { enable = true },
          closureReturnTypeHints = { enable = "always" },
          lifetimeElisionHints = { enable = "skip_trivial" },
          parameterHints = { enable = true },
          typeHints = { enable = true },
        },
        cargo = {
          features = "all",
        },
        check = {
          command = "clippy",
        },
        diagnostics = {
          enable = true,
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
}
