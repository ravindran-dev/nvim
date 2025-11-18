-- plugins/treesitter.lua
require('nvim-treesitter.configs').setup{
ensure_installed = { 'lua', 'python', 'c', 'cpp', 'javascript', 'typescript', 'rust', 'go', 'html', 'css', 'json' },
highlight = { enable = true, additional_vim_regex_highlighting = false },
indent = { enable = true },
}