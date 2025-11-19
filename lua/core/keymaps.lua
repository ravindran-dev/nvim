-- core/keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


map('n', '<leader>ff', ":Telescope find_files<CR>", opts)
map('n', '<leader>fg', ":Telescope live_grep<CR>", opts)
map('n', '<leader>fb', ":Telescope buffers<CR>", opts)
map('n', '<leader>fh', ":Telescope help_tags<CR>", opts)
map('n', '<leader>e', ":NvimTreeToggle<CR>", opts)
map('n', '<leader>gs', ":Gitsigns toggle_current_line_blame<CR>", opts)


map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)


map('n', '<leader>w', ':w<CR>', opts)


map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

