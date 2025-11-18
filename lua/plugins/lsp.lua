-- plugins/lsp.lua
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')
local lspconfig = require('lspconfig')


mason.setup()
mason_lsp.setup({ automatic_installation = true })


-- common on_attach
local on_attach = function(client, bufnr)
local bufmap = function(mode, lhs, rhs)
vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
end
bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
bufmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
end


-- enhance capabilities for nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp') and require('cmp_nvim_lsp')
if cmp_nvim_lsp then capabilities = cmp_nvim_lsp.default_capabilities(capabilities) end


-- default servers to setup
local servers = { 'pyright', 'clangd', 'tsserver', 'rust_analyzer', 'gopls', 'lua_ls' }
for _, lsp in ipairs(servers) do
lspconfig[lsp].setup({ on_attach = on_attach, capabilities = capabilities })
end