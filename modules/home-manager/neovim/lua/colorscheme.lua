local M = {}

function M.custom()
  require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "macchiato",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = true, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    },
  })

  -- setup must be called before loading
  vim.cmd.colorscheme("catppuccin")
end

-- This function sets the stylix colorscheme for Neovim
function M.stylix()
  local stylixPalette = nixCats.extra("base16colors")
  require("mini.base16").setup({
    palette = (function()
      local palette = {}
      for i = 0, 15 do
        local key = string.format("base%02X", i)
        if key == "base00" or key == "base01" then
          palette[key] = stylixPalette.base00
        else
          palette[key] = stylixPalette[key]
        end
      end
      return palette
    end)(),
  })

  vim.api.nvim_set_hl(0, "LineNr", {
    fg = stylixPalette.base0F,
  })
end

return M
