return {
    "zls",
    lsp = {
        filetypes = { "zig", "zir" },
        settings = {
            zls = {
                enable_inlay_hints = true,  -- ZLS supports inlay hints
                inlay_hints_show_variable_type_hints = true,
                inlay_hints_show_parameter_name = true,
                inlay_hints_show_builtin = true,
            },
        },
    },
}