
local map = vim.keymap.set
local opts = { noremap = true, silent = true }



vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files({
    hidden = true,
    file_ignore_patterns = { "^.git/" },
  })
end, { desc = "Find files (no .git)" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)


map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle file tree" }))


map("n", "<leader>gs", "<cmd>Gitsigns toggle_current_line_blame<CR>", opts)


map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)


map("n", "<leader>w", "<cmd>w<CR>", opts)


map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)


map("n", "<leader>gb", function() vim.cmd("GitBlameToggle") end, { desc = "Toggle Git Inline Blame", noremap = true, silent = true })

map("n", "<leader>lc", "<cmd>Leet<CR>", vim.tbl_extend("force", opts, { desc = "LeetCode: open UI" }))
map("n", "<leader>ld", "<cmd>Leet daily<CR>", vim.tbl_extend("force", opts, { desc = "LeetCode: daily problem" }))
map("n", "<leader>ll", "<cmd>Leet list<CR>", vim.tbl_extend("force", opts, { desc = "LeetCode: problem list" }))


map("n", "<leader>mp", "<cmd>Glow<CR>", vim.tbl_extend("force", opts, { desc = "Markdown Preview" }))


map("n", "<leader>lp", function() require("core.plugin_search").open() end, { desc = "Search Installed Plugins", noremap = true, silent = true })

map("n", "<leader>dd", function() require("core.dashboard").open() end, { desc = "Open R NVIM dashboard", noremap = true, silent = true })


map("n", "<leader>ss", function()
  local ok, persistence = pcall(require, "persistence")
  if ok and persistence.save then
    persistence.save()
  else
    vim.notify("persistence.nvim not available", vim.log.levels.WARN)
  end
end, { desc = "Save Session", noremap = true, silent = true })



map("v", "<C-c>", '"+y', opts)

map("n", "<C-c>", '"+yy', opts)

map("n", "<C-v>", '"+p', opts)
map("v", "<C-v>", '"+p', opts)
map("i", "<C-v>", "<C-r>+", opts)


map({ "n", "v" }, "x", '"_x', opts)
map("n", "X", '"_X', opts)
map({ "n", "v" }, "<Del>", '"_x', opts)


map("n", "<leader>mp", "<cmd>Glow<CR>", opts)

map("n", "<leader>?", function()
  require("core.support").open()
end, { noremap = true, silent = true, desc = "R NVIM: Support / Shortcuts" })

map("n", "<leader>sr", function()
  require("core.search").open_find_replace()
end, { desc = "Find & Replace (Scoped)" })



map("n", "<leader>sw", function()
  require("spectre").open_visual({ select_word = true })
end, { desc = "Replace word under cursor" })

map("v", "<leader>sw", function()
  require("spectre").open_visual()
end, { desc = "Replace selection" })

