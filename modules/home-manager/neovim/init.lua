vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.loader.enable()
vim.g.loaded_netrwPlugin = 1
vim.opt.mouse = ""
vim.o.scrolloff = 10
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

require("colorscheme").setup()

vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
    -- prefix = "●",
    -- spacing = 2,
  },
  -- signs = true,
  -- underline = true,
  -- severity_sort = true,
})

require("lze").register_handlers(require("lzextras").lsp)
require("lze").load({ { import = "plugins" } })
require("lsp")
