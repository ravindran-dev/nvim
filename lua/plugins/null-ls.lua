-- plugins/null-ls.lua
local null_ls = require('null-ls')
null_ls.setup({
sources = {
null_ls.builtins.formatting.prettier.with({ filetypes = { 'javascript', 'typescript', 'css', 'json', 'html' } }),
null_ls.builtins.formatting.black,
null_ls.builtins.diagnostics.eslint,
}
})