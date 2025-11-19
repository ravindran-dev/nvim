
require('lualine').setup()
require('bufferline').setup{}
require('nvim-tree').setup({ view = { side = 'left' } })



require('telescope').setup{
defaults = { file_ignore_patterns = { 'node_modules' }, layout_strategy = 'flex' }
}