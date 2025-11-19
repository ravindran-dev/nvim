-- ======================================================================
-- R NVIM DASHBOARD (ANIMATED • NON-SCROLLABLE • FIXED LAYOUT • BEAUTIFIED)
-- ======================================================================

local api = vim.api
local M = {}

---------------------------------------------------------------------
-- HEADER (Improved spacing + symmetrical look)
---------------------------------------------------------------------
local header = {
  "RRRRR     N   N    V     V   IIIII   M     M",
  "R    R    NN  N    V     V     I     MM   MM",
  "RRRRR     N N N     V   V      I     M M M M",
  "R   R     N  NN      V V       I     M  M  M",
  "R    R    N   N       V      IIIII   M     M",
  "",
  "R   N V I M",
}

---------------------------------------------------------------------
-- MENU (Aligned, padded, clean look)
---------------------------------------------------------------------
local menu = {
  { icon = "",  text = "Find File",        key = "f", cmd = "Telescope find_files" },
  { icon = "",  text = "New File",         key = "n", cmd = "enew" },
  { icon = "",  text = "Recent Files",     key = "r", cmd = "Telescope oldfiles" },
  { icon = "",  text = "Find Text",        key = "g", cmd = "Telescope live_grep" },
  { icon = "",  text = "Edit Config",      key = "c", cmd = "edit ~/.config/nvim/init.lua" },
  { icon = "",  text = "Restore Session",  key = "s", cmd = "lua require('persistence').load()" },
  { icon = "󰒲",  text = "Lazy Menu",        key = "l", cmd = "Lazy" },
  { icon = "",  text = "Quit",             key = "q", cmd = "qa" },
}

---------------------------------------------------------------------
-- CENTERING UTIL
---------------------------------------------------------------------
local function center(str)
  local win_width = vim.o.columns
  local pad = math.floor((win_width - #str) / 2)
  if pad < 0 then pad = 0 end
  return string.rep(" ", pad) .. str
end

---------------------------------------------------------------------
-- CREATE EMPTY DASHBOARD SPACE
---------------------------------------------------------------------
local function make_empty()
  local total = #header + (#menu * 2) + 10
  local pad_top = math.floor((vim.o.lines - total) / 2)

  local lines = {}

  for _ = 1, pad_top do table.insert(lines, "") end
  for _ = 1, total do table.insert(lines, "") end

  return lines, pad_top
end

---------------------------------------------------------------------
-- HEADER ANIMATION (Smooth + centered)
---------------------------------------------------------------------
local function animate_header(buf, pad_top)
  local i = 1

  local function step()
    if not api.nvim_buf_is_valid(buf) then return end
    if i > #header then return end

    vim.bo[buf].modifiable = true
    api.nvim_buf_set_lines(buf, pad_top + i, pad_top + i + 1, false, { center(header[i]) })
    vim.bo[buf].modifiable = false

    i = i + 1
    vim.defer_fn(step, 65) -- smoother animation
  end

  step()
end


local function render_menu(buf, pad_top)
  local start = pad_top + #header + 4
  local row = start

  for _, m in ipairs(menu) do
    local left = string.format("%s  %-20s", m.icon, m.text)
    local right = string.format("[%s]", m.key)

    local composed = left .. string.rep(" ", 30) .. right
    local line = center(composed)

    vim.bo[buf].modifiable = true
    api.nvim_buf_set_lines(buf, row, row + 1, false, { line })
    vim.bo[buf].modifiable = false

    row = row + 2
  end

  vim.bo[buf].modifiable = true
  api.nvim_buf_set_lines(buf, row + 1, row + 2, false, { center("⚡ Neovim ready.") })
  vim.bo[buf].modifiable = false

  return start
end


function M.open()
  vim.cmd("enew")
  local buf = api.nvim_get_current_buf()

  -- Window/UI settings
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false

  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = "no"
  vim.wo.cursorline = false
  vim.wo.wrap = false
  vim.wo.scrolloff = 99999   -- NO SCROLLING

  
  for _, key in ipairs({ "i", "a", "o", "O", "I", "A" }) do
    vim.keymap.set("n", key, "<nop>", { buffer = buf })
  end

  
  local lines, pad_top = make_empty()
  vim.bo[buf].modifiable = true
  api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  
  animate_header(buf, pad_top)

  
  vim.defer_fn(function()
    local start_row = render_menu(buf, pad_top)

    local ns = api.nvim_create_namespace("rnvim_dash")
    local current = 1

    local function highlight(idx)
      api.nvim_buf_clear_namespace(buf, ns, 0, -1)
      local row = start_row + (idx - 1) * 2
      api.nvim_buf_add_highlight(buf, ns, "Visual", row, 0, -1)
    end

    highlight(1)

    
    local opts = { noremap = true, silent = true, buffer = buf }

    vim.keymap.set("n", "j", function()
      current = math.min(#menu, current + 1)
      highlight(current)
    end, opts)

    vim.keymap.set("n", "k", function()
      current = math.max(1, current - 1)
      highlight(current)
    end, opts)

    vim.keymap.set("n", "<CR>", function()
      vim.cmd(menu[current].cmd)
    end, opts)

    
    for _, m in ipairs(menu) do
      vim.keymap.set("n", m.key, function()
        vim.cmd(m.cmd)
      end, opts)
    end

  end, 300)
end

return M
