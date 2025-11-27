-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General settings
vim.o.undofile = true
vim.o.mouse = 'a'
vim.o.confirm = true
vim.o.hidden = true
vim.o.modelines = 0

-- Indentation
local tabwidth = 4
vim.o.shiftwidth = tabwidth
vim.o.softtabstop = tabwidth
vim.o.tabstop = tabwidth
vim.o.expandtab = true
vim.o.breakindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.infercase = true

-- Line endings
vim.o.endofline = true
vim.o.fixendofline = true

-- UI
vim.o.relativenumber = true
vim.o.number = true
-- vim.o.colorcolumn = '80'
vim.o.signcolumn = 'yes'
vim.o.guicursor = 'i:block'
vim.o.termguicolors = true
vim.o.background = "dark"

-- Splits
vim.o.splitbelow = true
vim.o.splitright = true

-- Clipboard (deferred to avoid startup issues)
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Diagnostics
vim.diagnostic.config({ virtual_text = true })
