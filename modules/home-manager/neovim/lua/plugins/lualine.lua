return {
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
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
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
}
