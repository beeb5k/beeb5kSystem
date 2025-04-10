return {
    "clangd",
    lsp = {
        filetypes = { "c", "cpp", "objc", "objcpp" },
        settings = {
            clangd = {
                InlayHints = {
                    Enabled = true,  -- clangd supports inlay hints
                    ParameterNames = true,
                    TypeHints = true,
                    ChainedCalls = true,
                },
                fallbackFlags = { "-std=c17" }, -- or "-std=c++20" for C++
            },
        },
    },
}