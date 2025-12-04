local o = vim.opt

o.mouse = "a"
o.clipboard = "unnamedplus"

-- Line numbers
o.number = true
o.relativenumber = true

-- Colors / UI
o.termguicolors = true
o.signcolumn = "yes"
o.cursorline = true
o.wrap = false

-- Indentation
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- Files
o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = true

-- Scrolling / performance
o.scrolloff = 8
o.sidescrolloff = 8
o.updatetime = 250

-- Leader key
vim.g.mapleader = " "
