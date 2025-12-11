
local api = vim.api
local M = {}

local shortcuts = {
  { "R NVIM — Support / Shortcuts" },
  { "" },
  { "General" },
  { "  <leader>ff", "Find files" },
  { "  <leader>fg", "Live grep" },
  { "  <leader>fb", "List buffers" },
  { "  <leader>fh", "Help tags" },
  { "  <leader>e",  "Toggle file tree" },
  { "  <leader>dd", "Open R NVIM dashboard" },
  { "" },
  { "Editing" },
  { "  <C-c>", "Copy to clipboard" },
  { "  <C-v>", "Paste from clipboard" },
  { "  x / <Del>", "Delete without yanking" },
  { "" },
  { "Sessions" },
  { "  <leader>ss", "Save session" },
  { "  Dashboard → s", "Open last session" },
  { "" },
  { "REPL (iron.nvim)" },
  { "  <leader>ir", "Open REPL" },
  { "  <leader>sl", "Send line to REPL" },
  { "  <leader>sc", "Send selection to REPL" },
  { "" },
  { "Markdown" },
  { "  <leader>mp", "Markdown preview (Glow)" },
  { "" },
  { "LeetCode" },
  { "  <leader>lc", "Open LeetCode" },
  { "  <leader>ld", "Daily challenge" },
  { "  <leader>ll", "List problems" },
  { "" },
  { "Dashboard Navigation" },
  { "  j / k", "Move selection" },
  { "  <CR>", "Activate selected" },
  { "" },
  { "Window Navigation" },
  { "  <C-h> <C-j> <C-k> <C-l>", "Move between splits" },
  { "" },
  { "Close Popup" },
  { "  q / <Esc> / <leader>?", "Close support window" },
}

local function make_lines()
  local lines = {}
  for _, r in ipairs(shortcuts) do
    if #r == 1 then
      table.insert(lines, r[1])
    else
      table.insert(lines, string.format("%-18s    %s", r[1], r[2]))
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
    width = math.max(width, vim.fn.strdisplaywidth(l))
  end

  local height = #lines
  local buf = api.nvim_create_buf(false, true)

  api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  api.nvim_buf_set_option(buf, "buftype", "nofile")
  api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  local win_width = vim.o.columns
  local win_height = vim.o.lines

  local w = math.min(width + 6, math.floor(win_width * 0.8))
  local h = math.min(height + 4, math.floor(win_height * 0.8))

  local opts = {
    style = "minimal",
    relative = "editor",
    width = w,
    height = h,
    row = math.floor((win_height - h) / 2),
    col = math.floor((win_width - w) / 2),
    border = "rounded",
  }

  local win = api.nvim_open_win(buf, true, opts)
  M.win = win
  M.buf = buf

  api.nvim_buf_add_highlight(buf, -1, "Title", 0, 0, -1)

  local function close()
    if api.nvim_win_is_valid(win) then
      api.nvim_win_close(win, true)
      M.win = nil
      M.buf = nil
    end
  end

  api.nvim_buf_set_keymap(buf, "n", "q", "", { noremap = true, callback = close })
  api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", { noremap = true, callback = close })
  api.nvim_buf_set_keymap(buf, "n", "<leader>?", "", { noremap = true, callback = close })

  api.nvim_win_set_cursor(win, { 1, 0 })
  api.nvim_buf_set_option(buf, "modifiable", false)
end

return M
