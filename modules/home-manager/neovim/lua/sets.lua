-- ================================
-- ⚡ Performance
-- ================================
vim.loader.enable()             -- Enable faster Lua module loading
vim.opt.updatetime = 50        -- Faster completion and CursorHold events

-- ================================
-- 🖥️ User Interface
-- ================================
vim.opt.guicursor = ""         -- Use block cursor
vim.opt.termguicolors = true   -- Enable 24-bit RGB colors
vim.opt.showmode = false       -- Don't show mode (handled by statusline)
vim.opt.showcmd = false        -- Hide command in the last line
vim.opt.signcolumn = "yes"     -- Always show sign column
vim.opt.colorcolumn = "85"     -- Highlight column 85
vim.opt.cursorline = true      -- Highlight current line

-- ================================
-- 🔢 Line Numbers
-- ================================
vim.opt.nu = true              -- Absolute line numbers
vim.opt.relativenumber = true  -- Relative line numbers

-- ================================
-- 🖱️ Mouse and Scrolling
-- ================================
vim.opt.mouse = ""             -- Disable mouse support
vim.opt.scrolloff = 20         -- Keep 20 lines above/below cursor

-- ================================
-- 🔑 Keybindings
-- ================================
vim.g.mapleader = " "          -- Set leader key to Space

-- ================================
-- 📁 File Explorer & File Handling
-- ================================
vim.g.loaded_netrwPlugin = 1   -- Disable netrw file explorer
vim.opt.isfname:append("@-@")  -- Allow @ in filenames

-- ================================
-- 🔤 Indentation and Tabs
-- ================================
vim.opt.expandtab = true       -- Convert tabs to spaces
vim.opt.tabstop = 4            -- Number of spaces per tab
vim.opt.softtabstop = 4        -- Number of spaces for soft tab
vim.opt.shiftwidth = 4         -- Number of spaces for indent
vim.opt.smartindent = true     -- Smart autoindenting
vim.opt.smarttab = true        -- Use shiftwidth at beginning of lines
vim.opt.breakindent = true     -- Wrap indent to match line start
vim.opt.backspace = { "indent", "eol", "start" }  -- Allow backspace through everything
vim.opt.autoindent = true      -- Copy indent from current line when starting new one

-- ================================
-- 🔃 Text Wrapping
-- ================================
vim.opt.wrap = false           -- Disable line wrapping
vim.opt.linebreak = true       -- Wrap long lines at word boundaries

-- ================================
-- 🔍 Search
-- ================================
vim.opt.hlsearch = false       -- Don't highlight search results
vim.opt.incsearch = true       -- Show search matches as you type

-- ================================
-- 🏷️ Misc
-- ================================
vim.opt.title = true           -- Set terminal title to file name

