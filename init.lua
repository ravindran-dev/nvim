

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy")
require("core.dashboard")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
  require("core.dashboard").open()
  end,
})
vim.opt.shortmess:append("I")
-- Open horizontal terminal
vim.keymap.set("n", "<leader>th", ":belowright split | terminal<CR>")

-- Open vertical terminal
vim.keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>")

-- Toggle floating terminal
vim.keymap.set("n", "<leader>tf", function()
  require("core.floatterm").toggle()
end)
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("startinsert")
  end
})
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("n", "<leader>t", ":FloatermToggle<CR>")
vim.keymap.set("t", "<leader>t", "<C-\\><C-n>:FloatermToggle<CR>")
-- CTRL+A = Select All
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })
vim.opt.clipboard = "unnamedplus"
-- Ctrl + C = Copy selection / copy line
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "<C-c>", '"+yy', { noremap = true, silent = true })

-- Ctrl + V = Paste
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", '<Esc>"+pa', { noremap = true, silent = true })
vim.keymap.set("v", "<C-v>", '"+p', { noremap = true, silent = true })
-- Ctrl+A in NORMAL mode (Select All)
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- Ctrl+A in INSERT mode (Select All)
vim.keymap.set("i", "<C-a>", function()
  vim.cmd("normal! ggVG")
end, { noremap = true, silent = true })
-- Ctrl+Z in NORMAL mode (Undo)
vim.keymap.set("n", "<C-z>", "u", { noremap = true, silent = true })

-- Ctrl+Z in INSERT mode (Undo)
vim.keymap.set("i", "<C-z>", function()
  vim.cmd("normal! u")
end, { noremap = true, silent = true })
-- Ctrl+Y in NORMAL mode (Redo)
vim.keymap.set("n", "<C-y>", "<C-r>", { noremap = true, silent = true })

-- Ctrl+Y in INSERT mode (Redo)
vim.keymap.set("i", "<C-y>", function()
  vim.cmd("normal! <C-r>")
end, { noremap = true, silent = true })
