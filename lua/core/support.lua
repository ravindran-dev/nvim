-- lua/core/support.lua
local api = vim.api
local M = {}

local shortcuts = {
  { "R NVIM — Support / Shortcuts" },
  { "" },
  { "General" },
  { "  <leader>ff", "Telescope: Find files" },
  { "  <leader>fg", "Telescope: Live grep" },
  { "  <leader>fb", "Telescope: Buffers" },
  { "  <leader>fh", "Telescope: Help tags" },
  { "  <leader>e",  "Toggle file tree (NvimTree)" },
  { "  <leader>dd", "Open R NVIM dashboard" },
  { "" },
  { "Editing" },
  { "  <C-c>", "Copy (system clipboard)" },
  { "  <C-v>", "Paste (system clipboard)" },
  { "  x / <Del>", "Delete without yanking (black-hole)" },
  { "" },
  { "Session / Projects" },
  { "  <leader>ss", "Save session (persistence.nvim)" },
  { "  <leader>dd -> s", "Open Last Session from dashboard" },
  { "" },
  { "REPL & Tools" },
  { "  <leader>ir", "Open REPL for current filetype (iron.nvim)" },
  { "  <leader>sl", "Send line to REPL" },
  { "  <leader>mp", "Markdown preview (Glow)" },
  { "" },
  { "LeetCode" },
  { "  <leader>lc", "Open LeetCode UI" },
  { "  <leader>ld", "Daily LeetCode" },
  { "  <leader>ll", "List problems" },
  { "" },
  { "Dashboard / Navigation" },
  { "  j / k / <Down> / <Up>", "Move selection in dashboard" },
  { "  <CR>", "Activate selected menu item" },
  { "" },
  { "Window Management" },
  { "  <C-h> <C-j> <C-k> <C-l>", "Move between splits" },
  { "" },
  { "Close popup" },
  { "  q  <Esc>  <leader>?", "Close this window" },
}

local function make_lines()
  local lines = {}
  for _, r in ipairs(shortcuts) do
    if #r == 1 then
      table.insert(lines, r[1])
    else
      -- pad right side so second column lines align
      local left = r[1]
      local right = r[2] or ""
      local sep = "    "
      table.insert(lines, string.format("%-18s%s%s", left, sep, right))
    end
  end
  return lines
end

function M.open()
  if M.win and api.nvim_win_is_valid(M.win) then
    api.nvim_set_current_win(M.win)
    return
  end

  local lines = make_lines()
  local width = 0
  for _, l in ipairs(lines) do
    local len = vim.fn.strdisplaywidth(l)
    if len > width then width = len end
  end
  local height = #lines

  local buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(buf, "buftype", "nofile")
  api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local win_width = vim.o.columns
  local win_height = vim.o.lines

  local win_w = math.min(width + 6, math.floor(win_width * 0.8))
  local win_h = math.min(height + 4, math.floor(win_height * 0.8))

  local row = math.floor((win_height - win_h) / 2)
  local col = math.floor((win_width - win_w) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_w,
    height = win_h,
    row = row,
    col = col,
    border = "rounded",
  }

  local win = api.nvim_open_win(buf, true, opts)
  M.win = win
  M.buf = buf

  -- highlights
  api.nvim_buf_add_highlight(buf, -1, "Title", 0, 0, -1)

  -- keymaps to close
  local close = function()
    if api.nvim_win_is_valid(win) then
      api.nvim_win_close(win, true)
      M.win = nil
      M.buf = nil
    end
  end

  api.nvim_buf_set_keymap(buf, "n", "q", "", { noremap = true, callback = close })
  api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", { noremap = true, callback = close })
  -- toggle with same leader mapping
  api.nvim_buf_set_keymap(buf, "n", "<leader>?", "", { noremap = true, callback = close })

  -- keep cursor at top-left
  api.nvim_win_set_cursor(win, {1,0})
  -- make buffer readonly
  api.nvim_buf_set_option(buf, "modifiable", false)
end

return M

