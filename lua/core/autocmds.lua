-- core/autocmds.lua
local api = vim.api


-- Remove trailing whitespace on save
api.nvim_create_autocmd('BufWritePre', {
pattern = '*',
callback = function()
local view = vim.fn.winsaveview()
vim.cmd([[%s/\s\+$//e]])
vim.fn.winrestview(view)
end,
})


-- Highlight on yank
api.nvim_create_autocmd('TextYankPost', {
callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})