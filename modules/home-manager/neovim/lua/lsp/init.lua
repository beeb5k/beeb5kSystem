vim.lsp.enable({ "clangd", "pyright", "zls", "nil_ls", "lua_ls", "rust_analyzer", "tsserver" })

vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { ".git", ".editorconfig", "flake.nix", "shell.nix", "flake.lock" },
})

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd" },
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
})

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoImportCompletions = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        autoSearchPaths = true,
        --[[ 
          this does not support inlay hints
          man i love em :(
        ]]
      },
    },
  },
})

vim.lsp.config("zls", {
  cmd = { "zls" },
  filetypes = { "zig" },
  settings = {
    zls = {
      enable_inlay_hints = true,
      inlay_hints_show_variable_type_hints = true,
      inlay_hints_show_parameter_name = true,
      inlay_hints_show_builtin = true,
    },
  },
})

vim.lsp.config("nil_ls", {
  cmd = { "nil" },
  filetypes = { "nix" },
  ["nil"] = {
    formatting = {
      command = { "nixfmt-unstable" },
    },
  },
})

vim.lsp.config("tsserver", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "javascript",
    "javascriptreact",
    "javascript.jsx",
  },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },

  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all", -- or "literals" / "none"
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
})

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
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
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      hint = {
        enabled = true,
      },
      runtime = {
        version = "LuaJIT",
      },
      formatters = {
        ignoreComments = true,
      },
      signatureHelp = {
        enabled = true,
      },
      diagnostics = {
        globals = { "vim" },
        disable = { "missing-fields" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          -- '${3rd}/luv/library',
          -- unpack(vim.api.nvim_get_runtime_file('', true)),
        },
      },
      completion = {
        callSnippet = "Replace",
      },
      telemetry = {
        enabled = false,
      },
    },
  },
})
