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
-- Copy selected text using Ctrl + C
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
-- Paste with Ctrl + V
vim.keymap.set("i", "<C-v>", '<Esc>"+pa', { noremap = true, silent = true })
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("v", "<C-v>", '"+p', { noremap = true, silent = true })


map('n', '<leader>w', ':w<CR>', opts)


map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)


-- Toggle inline git blame
vim.keymap.set("n", "<leader>gb", function()
  vim.cmd("GitBlameToggle")
end, { desc = "Toggle Git Inline Blame" })

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- LeetCode: main panel
map("n", "<leader>lc", "<cmd>Leet<CR>", vim.tbl_extend("force", opts, { desc = "LeetCode: open UI" }))

-- LeetCode: daily challenge
map("n", "<leader>ld", "<cmd>Leet daily<CR>", vim.tbl_extend("force", opts, { desc = "LeetCode: daily problem" }))

-- LeetCode: problem list (filtered / searchable)
map("n", "<leader>ll", "<cmd>Leet list<CR>", vim.tbl_extend("force", opts, { desc = "LeetCode: problem list" }))
vim.keymap.set("n", "<leader>lc", "<cmd>Leet<CR>", { desc = "Open LeetCode UI" })
vim.keymap.set("n", "<leader>ld", "<cmd>Leet daily<CR>", { desc = "Daily Challenge" })
vim.keymap.set("n", "<leader>ll", "<cmd>Leet list<CR>", { desc = "LeetCode Problems" })
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>mp", "<cmd>Glow<CR>", vim.tbl_extend("force", opts, { desc = "Markdown Preview" }))

vim.keymap.set("n", "<leader>lp", function()
  require("core.plugin_search").open()
end, { desc = "Search Installed Plugins" })
local map = vim.keymap.set

map("n", "<leader>dd", function()
  require("core.dashboard").open()
end, { desc = "Open R NVIM dashboard" })

vim.keymap.set("n", "<leader>ss", function()
  require("persistence").save()
end, { desc = "Save Session" })
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle file tree" })


local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<C-c>", '"+y', opts)
map("v", "<C-c>", '"+y', opts)

map("n", "<C-v>", '"+p', opts)
map("v", "<C-v>", '"+p', opts)
map("i", "<C-v>", '<C-r>+', opts)

map({ "n", "v" }, "x", '"_x', opts)
map("n", "X", '"_X', opts)
map({ "n", "v" }, "<Del>", '"_x', opts)
