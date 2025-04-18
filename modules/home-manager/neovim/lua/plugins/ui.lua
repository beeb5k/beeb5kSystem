return {
  {
    "lualine.nvim",
    event = { "DeferredUIEnter" },
    after = function(_)
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = colorschemer,
          component_separators = {
            left = "|",
            right = "|",
          },
          section_separators = {
            left = "",
            right = "",
          },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", { "diff" }, "diagnostics" },
          lualine_c = {
            {
              "filename",
              path = 1,
              status = true,
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {
            {
              "filename",
              path = 3,
              status = true,
            },
          },
          lualine_c = {},
          lualine_x = { "filetype" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  {
    "mini.starter",
    event = { "VimEnter" },
    after = function()
      require("mini.starter").setup({
        header = table.concat({
          " .-----------------------------------------.",
          " | Python is a toy language.               |",
          " '-----------------------------------------'",
          "        o   ^__^                              ",
          "         o  (oo)\\_______                      ",
          "            (__)\\       )\\/\\                 ",
          "                ||----w |                     ",
          "                ||     ||                     ",
        }, "\n"),
        footer = "Almost every programming language is\noverrated by its practitioners.\n- Larry Wall",
      })
    end,
  },
}
