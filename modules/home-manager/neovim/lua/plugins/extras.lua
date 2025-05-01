return {
  {
    "ultimate-autopair.nvim",
    event = { "InsertEnter" },
    after = function()
      require("ultimate-autopair").setup({})
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
  {
    "oil.nvim",
    event = "CmdlineEnter",
    after = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = { "icon", "permissions", "size" },
        keymaps = {
          ["-"] = "actions.parent",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
        },
      })
    end,
    keys = { {
      "-",
      "<CMD>Oil<CR>",
      desc = "Open Oil",
    } },
  },
  {
    "nvim-ts-autotag",
    event = { "InsertEnter" },
    after = function()
      require("nvim-ts-autotag").setup({
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
      })
    end,
  },
  {
    "neogit",
    event = { "DeferredUIEnter" },
    after = function ()
      require("neogit").setup({})
    end
  }, 
  {
    "gitsigns.nvim",
    event = { "BufReadPost" },
    after = function ()
      require("gitsigns").setup({})
    end
  }
}
