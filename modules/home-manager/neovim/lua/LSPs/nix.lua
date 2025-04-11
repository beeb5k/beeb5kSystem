return {
  "nil_ls",
  lsp = {
    filetypes = { "nix" },
    settings = {
      ["nil"] = {
        formatting = {
          command = { "nixfmt-unstable" },
        },
      },
    },
  },
}
