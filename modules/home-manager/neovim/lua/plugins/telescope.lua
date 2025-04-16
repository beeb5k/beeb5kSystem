return {
  {
    "telescope.nvim",
    event = { "DeferredUIEnter" },
    after = function()
      require("telescope").setup({})
      vim.keymap.set("n", "<leader>ff", ":Telescope fd<CR>", {
        desc = "[F]ind [F]iles",
      })
    end,
  },
}
