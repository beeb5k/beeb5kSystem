return {
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
}
