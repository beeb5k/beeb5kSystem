-- Performance
vim.loader.enable()
vim.opt.updatetime = 50

-- User Interface
vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "85"

-- Line Numbers
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Mouse and Cursor
vim.opt.mouse = ""
vim.o.scrolloff = 10

-- Leader Key
vim.g.mapleader = " "

-- File Explorer
-- vim.g.loaded_netrwPlugin = 1
vim.opt.isfname:append("@-@")

-- Indentation and Tabs
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Text Wrapping
vim.o.wrap = false
vim.o.linebreak = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
