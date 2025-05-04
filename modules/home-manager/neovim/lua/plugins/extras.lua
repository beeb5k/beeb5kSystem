return {
  {
    "nvim-autopairs",
    event = { "InsertEnter" },
    after = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },
  {
    "nvim-surround",
    event = { "DeferredUIEnter" },
    after = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "tabout.nvim",
    event = { "InsertEnter" },
    after = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
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
    event = "DeferredUIEnter",
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
    after = function()
      require("neogit").setup({})
    end,
  },
  {
    "gitsigns.nvim",
    event = { "BufReadPost" },
    after = function()
      require("gitsigns").setup({})
    end,
  },
}
