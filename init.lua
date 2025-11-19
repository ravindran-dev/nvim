

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