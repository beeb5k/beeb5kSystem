vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.showmode = false
vim.g.mapleader = "."
vim.g.maplocalleader = "."
vim.loader.enable()
vim.g.loaded_netrwPlugin = 1
vim.opt.mouse = ""
vim.o.scrolloff = 10

-- vim.lsp.inlay_hint.enable(true)

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

require("lze").register_handlers(require("lzextras").lsp)
require("lze").load({ { import = "plugins" }, { import = "LSPs" } })
