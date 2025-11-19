-- plugins/telescope.lua
local telescope = require('telescope')
local actions = require('telescope.actions')





telescope.setup({
defaults = {
prompt_prefix = "  ",
selection_caret = " ",
path_display = { "smart" },


file_ignore_patterns = {
"node_modules",
"%.git/",
"%.cache/",
},


mappings = {
i = {
["<C-j>"] = actions.move_selection_next,
["<C-k>"] = actions.move_selection_previous,
["<esc>"] = actions.close,
},
},
},
})

