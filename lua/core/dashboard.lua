local api = vim.api

-- Path to your PNG
local img = "/home/ravi/iron2.png"

-- Clean screen
vim.cmd("silent! %bwipeout!")
vim.cmd("silent! enew")

local buf = api.nvim_get_current_buf()

-- Dashboard text
local lines = {
  "",
  "",
  "",
  "               🦾  Welcome Back, Ravi!",
  "",
  "  [1]  Find Files",
  "  [2]  Recent Files",
  "  [3]  New File",
  "  [4]  Edit Config",
  "  [5]  Quit Neovim",
  "",
  "",
}

api.nvim_buf_set_lines(buf, 0, -1, false, lines)

-- No line numbers
vim.opt.number = false
vim.opt.relativenumber = false

-- Keybinds for dashboard buttons
api.nvim_buf_set_keymap(buf, "n", "1", ":Telescope find_files<CR>", { noremap = true, silent = true })
api.nvim_buf_set_keymap(buf, "n", "2", ":Telescope oldfiles<CR>", { noremap = true, silent = true })
api.nvim_buf_set_keymap(buf, "n", "3", ":enew<CR>", { noremap = true, silent = true })
api.nvim_buf_set_keymap(buf, "n", "4", ":edit ~/.config/nvim/init.lua<CR>", { noremap = true, silent = true })
api.nvim_buf_set_keymap(buf, "n", "5", ":qa<CR>", { noremap = true, silent = true })

-- Display image using hologram
vim.defer_fn(function()
  local hologram = require("hologram")
  hologram.display_image(img, {
    x = 5,    -- horizontal offset
    y = 2,    -- vertical offset
    width = 60,  -- resize image width
  })
end, 100)
