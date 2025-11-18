-- Clean, centered, non-scrollable R NVIM dashboard

local api = vim.api

local header = {
  "RRRRR    N   N  V     V  IIIII  M     M",
  "R    R   NN  N  V     V    I    MM   MM",
  "RRRRR    N N N   V   V     I    M M M M",
  "R  R     N  NN    V V      I    M  M  M",
  "R   R    N   N     V     IIIII  M     M",
  "",
  "                 R  N V I M",
}

local menu = {
  { icon = " ", text = "Find File",        key = "f", cmd = "Telescope find_files" },
  { icon = " ", text = "New File",         key = "n", cmd = "enew" },
  { icon = " ", text = "Recent Files",     key = "r", cmd = "Telescope oldfiles" },
  { icon = " ", text = "Find Text",        key = "g", cmd = "Telescope live_grep" },
  { icon = " ", text = "Edit Config",      key = "c", cmd = "edit ~/.config/nvim/init.lua" },
  { icon = " ", text = "Restore Session",  key = "s", cmd = "lua require('persistence').load()" },
  { icon = "󰒲 ", text = "Lazy ",             key = "l", cmd = "Lazy" },
  { icon = " ", text = "Quit",             key = "q", cmd = "qa" },
}

local function center(str)
  local width = vim.o.columns
  local pad = math.max(math.floor((width - #str) / 2), 0)
  return string.rep(" ", pad) .. str
end

local function open_dashboard()
  vim.cmd("enew")
  local buf = api.nvim_get_current_buf()

  -- Make buffer non-scrollable
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true

  -- UI cleanup
  vim.wo[0].number = false
  vim.wo[0].relativenumber = false
  vim.wo[0].cursorline = false
  vim.wo[0].signcolumn = "no"
  vim.wo[0].foldcolumn = "0"
  vim.wo[0].wrap = false

  -- compute vertical center
  local total = #header + (#menu * 2) + 6
  local top_padding = math.max(math.floor((vim.o.lines - total) / 2), 0)

  local lines = {}

  -- Add top padding
  for _ = 1, top_padding do
    table.insert(lines, "")
  end

  -- Add centered header
  for _, h in ipairs(header) do
    table.insert(lines, center(h))
  end

  table.insert(lines, "")
  table.insert(lines, "")

  -- Add menu items with clean spacing
  for _, m in ipairs(menu) do
    local left = m.icon .. m.text
    local spacing = string.rep(" ", 50 - #left)
    table.insert(lines, center(left .. spacing .. m.key))
    table.insert(lines, "")
  end

  table.insert(lines, center("⚡ Neovim ready."))

  -- Write lines
  api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  -- Keymaps
  for _, m in ipairs(menu) do
    vim.keymap.set("n", m.key, function()
      vim.cmd(m.cmd)
    end, { buffer = buf, silent = true })
  end
end

open_dashboard()
return {}
