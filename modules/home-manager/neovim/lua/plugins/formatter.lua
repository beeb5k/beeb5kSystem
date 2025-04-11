return {
  "conform.nvim",
  keys = { {
    "<leader>fm",
    desc = "[F]ormat [F]ile",
  } },
  after = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run multiple formatters sequentially
        -- python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        -- Conform will run the first available formatter
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, {
      desc = "[F]or[M]at",
    })
  end,
}
