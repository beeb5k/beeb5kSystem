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
        go = { "gofmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
        python = { "isort", "black" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cmake = { "cmake_format" },
        javascript = { "biome --indent-style=space" },
        javascriptreact = { "biome --indent-style=space" },
        typescript = { "biome --indent-style=space" },
        typescriptreact = { "biome --indent-style=space" },
        json = { "biome --indent-style=space" },
        jsonc = { "biome --indent-style=space" },
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
