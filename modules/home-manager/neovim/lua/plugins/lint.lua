return {
  "nvim-lint",
  event = { "FileType" },
  after = function(_)
    require("lint").linters_by_ft = {
      go = { "golangcilint" },
      javascript = { "eslint" },
      typescript = { "eslint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
