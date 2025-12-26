-- core/autocmds.lua
local api = vim.api



api.nvim_create_autocmd('BufWritePre', {
pattern = '*',
callback = function()
local view = vim.fn.winsaveview()
vim.cmd([[%s/\s\+$//e]])
vim.fn.winrestview(view)
end,
})



api.nvim_create_autocmd('TextYankPost', {
callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})


vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = function()
    local ft = vim.bo.filetype
    local bt = vim.bo.buftype

    -- Skip dashboard, help, nofile, terminal, floating windows
    if bt ~= "" or ft == "dashboard" or ft == "help" then
      return
    end

    vim.wo.number = true
    vim.wo.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#111111" })
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#0a0a0a" })
  end,
})
