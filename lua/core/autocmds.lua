-- core/autocmds.lua
local api = vim.api



api.nvim_create_autocmd('BufWritePre', {
pattern = '*',
callback = function()
local view = vim.fn.winsaveview()
vim.cmd([[%s/\s\+$//e]])
vim.fn.winrestview(view)
end,
})



api.nvim_create_autocmd('TextYankPost', {
callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})