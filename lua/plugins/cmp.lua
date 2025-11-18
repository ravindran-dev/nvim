-- plugins/cmp.lua
local cmp = require('cmp')
local luasnip = require('luasnip')


cmp.setup({
snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
mapping = cmp.mapping.preset.insert({ ['<C-Space>'] = cmp.mapping.complete(), ['<CR>'] = cmp.mapping.confirm({ select = true }) }),
sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'buffer' }, { name = 'path' } }),
})