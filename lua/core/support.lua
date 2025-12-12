-- lua/core/support.lua
local api = vim.api
local M = {}

local help_lines = {
  "R NVIM - Support / Shortcuts",
  "",
  "General",
  "  <leader>ff        Find files",
  "  <leader>fg        Live grep",
  "  <leader>fb        List buffers",
  "  <leader>fh        Help tags",
  "  <leader>e         Toggle file tree",
  "  <leader>dd        Open R NVIM dashboard",
  "",
  "Editing",
  "  <C-c>             Copy to clipboard",
  "  <C-v>             Paste from clipboard",
  "  x / <Del>         Delete without yanking",
  "",
  "Sessions",
  "  <leader>ss        Save session",
  "  Dashboard -> s    Open last session",
  "",
  "REPL (iron.nvim)",
  "  <leader>ir        Open REPL",
  "  <leader>sl        Send line to REPL",
  "  <leader>sc        Send selection to REPL",
  "",
  "Markdown",
  "  <leader>mp        Markdown preview (Glow)",
  "",
  "LeetCode",
  "  <leader>lc        Open LeetCode UI",
  "  <leader>ld        Daily challenge",
  "  <leader>ll        List problems",
  "",
  "Dashboard Navigation",
  "  j / k             Move selection",
  "  <CR>              Activate selected",
  "",
  "Window Navigation",
  "  <C-h> <C-j> <C-k> <C-l>   Move between splits",
  "",
  "Close Popup",
  "  q  /  <Esc>  /  <leader>?   Close support window",
}

local function make_buf()
  local buf = api.nvim_create_buf(false, true) -- listed=false, scratch=true
  api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  api.nvim_buf_set_option(buf, "filetype", "rnvim-support")
  return buf
end

local function center_dims(width_pct, height_pct)
  local sw = vim.o.columns
  local sh = vim.o.lines
  local w = math.floor(sw * (width_pct or 0.75))
  local h = math.floor(sh * (height_pct or 0.70))
  local col = math.floor((sw - w) / 2)
  local row = math.floor((sh - h) / 2) - 1
  if row < 0 then row = 0 end
  return { row = row, col = col, width = w, height = h }
end

local win_id = nil
local buf_id = nil

function M.open(opts)
  opts = opts or {}
  local width_pct = opts.width_pct or 0.72
  local height_pct = opts.height_pct or 0.72

  -- if window already open, bounce focus to it
  if win_id and api.nvim_win_is_valid(win_id) then
    api.nvim_set_current_win(win_id)
    return
  end

  buf_id = make_buf()
  api.nvim_buf_set_option(buf_id, "modifiable", true)
  api.nvim_buf_set_lines(buf_id, 0, -1, false, help_lines)
  api.nvim_buf_set_option(buf_id, "modifiable", false)

  local dims = center_dims(width_pct, height_pct)

  local win_opts = {
    relative = "editor",
    width = dims.width,
    height = dims.height,
    row = dims.row,
    col = dims.col,
    style = "minimal",
    border = "rounded",
  }

  win_id = api.nvim_open_win(buf_id, true, win_opts)

  -- window local options
  api.nvim_win_set_option(win_id, "wrap", false)
  api.nvim_win_set_option(win_id, "number", false)
  api.nvim_win_set_option(win_id, "relativenumber", false)
  api.nvim_win_set_option(win_id, "cursorline", false)

  -- keymaps for closing the popup inside the popup buffer
  local close = function()
    if win_id and api.nvim_win_is_valid(win_id) then
      pcall(api.nvim_win_close, win_id, true)
    end
    if buf_id and api.nvim_buf_is_valid(buf_id) then
      pcall(api.nvim_buf_delete, buf_id, { force = true })
    end
    win_id = nil
    buf_id = nil
  end

  local function set_buf_keymap(lhs, rhs)
    api.nvim_buf_set_keymap(buf_id, "n", lhs, rhs, { nowait = true, noremap = true, silent = true })
  end

  set_buf_keymap("q", ":lua require('core.support').close()<CR>")
  set_buf_keymap("<Esc>", ":lua require('core.support').close()<CR>")
  set_buf_keymap("<leader>?", ":lua require('core.support').close()<CR>")

  -- also allow <CR> to jump cursor or expand? keep it simple: no action
  -- keep the buffer focus so users can read and scroll
  -- enable basic scrolling keys in the popup
  api.nvim_buf_set_keymap(buf_id, "n", "<C-u>", "<C-u>", { nowait = true, noremap = true, silent = true })
  api.nvim_buf_set_keymap(buf_id, "n", "<C-d>", "<C-d>", { nowait = true, noremap = true, silent = true })

  -- expose close function
  M.close = close
end

function M.close()
  if win_id and api.nvim_win_is_valid(win_id) then
    pcall(api.nvim_win_close, win_id, true)
  end
  if buf_id and api.nvim_buf_is_valid(buf_id) then
    pcall(api.nvim_buf_delete, buf_id, { force = true })
  end
  win_id = nil
  buf_id = nil
end

return M

