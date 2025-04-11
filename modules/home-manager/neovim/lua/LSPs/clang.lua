return {
  "clangd",
  lsp = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    settings = {
      clangd = {
        InlayHints = {
          Enabled = true,
          ParameterNames = true,
          TypeHints = true,
          ChainedCalls = true,
        },
        fallbackFlags = { "-std=c17" },
      },
    },
  },
}
