return {
  {
    "nvim-autopairs",
    event = { "InsertEnter" },
    after = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "comment.nvim",
    event = { "BufReadPost" },
    after = function()
      require("Comment").setup({})
    end,
  },
  {
    "eyeliner.nvim",
    event = { "DeferredUIEnter" },
    after = function()
      require("eyeliner").setup({
        highlight_on_key = true,
        dim = true,
      })
    end,
  },
  {
    "which-key.nvim",
    event = { "DeferredUIEnter" },
    after = function()
      require("which-key").setup({})
    end,
  },
  {
    "indent-blankline.nvim",
    event = { "BufReadPost" },
    after = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = { enabled = false },
      })
    end,
  },
  {
    "bufferline.nvim",
    event = { "BufReadPost" },
    after = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({})
    end,
  },
  {
    "nvim-web-devicons",
    event = { "DeferredUIEnter" },
    after = function()
      require("nvim-web-devicons").setup({
        default = true,
      })
    end,
  },
  {
    "cord.nvim",
    event = { "DeferredUIEnter" },
    after = function()
      require("cord").setup({
        editor = {
          tooltip = "I use nixos, btw.",
        },
        idle = {
          enabled = true,
        },
        advanced = {
          discord = {
            reconnect = {
              enabled = true,
              interval = 5000,
              initial = true,
            },
          },
        },
      })
    end,
  },
}
