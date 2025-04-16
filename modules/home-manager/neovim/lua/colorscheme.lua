local M = {}

function M.setup()
  require("kanagawa").setup({
    compile = true, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false, -- do not set background color
    dimInactive = true, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    theme = "wave", -- Load "wave" theme
    background = { -- map the value of 'background' option to a theme
      dark = "dragon", -- try "dragon" !
      light = "lotus",
    },
  })

  -- setup must be called before loading
  vim.cmd("colorscheme kanagawa")

  -- stylix palette

  --[[ local stylixPalette = nixCats.extra("base16colors")
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
    }) ]]
end

return M
