return {
  "conform.nvim",
  keys = { {
    "<leader>fm",
    desc = "[F]or[M]at",
  } },
  after = function()
    local conform = require("conform")

    conform.setup({
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },

      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt" },
        go = { "gofmt", "golint" },
        rust = { "rustfmt", lsp_format = "fallback" },
        python = { "isort", "black" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cmake = { "cmake_format" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 500,
      })
    end, {
      desc = "[F]or[M]at",
    })
  end,
}
