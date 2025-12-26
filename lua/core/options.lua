local o = vim.opt

o.mouse = "a"
o.clipboard = "unnamedplus"


o.number = true
o.relativenumber = false


o.termguicolors = true
o.signcolumn = "yes"
o.cursorline = true
o.wrap = false


o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true


o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = true


o.scrolloff = 8
o.sidescrolloff = 8
o.updatetime = 250

vim.g.mapleader = " "
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})
vim.cmd([[
  highlight Normal guibg=#000000
  highlight NormalNC guibg=#000000
  highlight EndOfBuffer guibg=#000000
  highlight SignColumn guibg=#000000
  highlight LineNr guibg=#000000
  highlight CursorLineNr guibg=#000000
]])
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7aa2ff", bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#bb9af7", bg = "#000000" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#000000" })
vim.opt.guicursor =
  "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr:hor20-Cursor"
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = true,
  underline = true,
})

vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.guicursor =
  "n-v-c:block-Cursor/lCursor," ..
  "i-ci-ve:ver25-Cursor/lCursor," ..
  "r-cr:hor20-Cursor/lCursor," ..
  "o:hor50-Cursor/lCursor"
