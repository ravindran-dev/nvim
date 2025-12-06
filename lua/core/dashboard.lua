local api = vim.api
local M = {}
local system = require("core.system")

-- Lua memory usage
local function get_memory_usage()
  local kb = collectgarbage("count") -- KB
  local mb = math.floor(kb / 1024 * 100) / 100
  return string.format(" Lua memory: %.2f MB", mb)
end

-- Time-based greeting
local function get_greeting()
  local hour = tonumber(os.date("%H"))

  if hour < 5 then
    return "🌙 Late night – go easy on yourself."
  elseif hour < 12 then
    return "🌅 Good morning – ready to ship something?"
  elseif hour < 18 then
    return "☀️ Good afternoon – keep building."
  else
    return "🌆 Good evening – time to grind."
  end
end

-- Clock
local function get_clock()
  return os.date("  %I:%M %p     %d %b %Y")
end

-- Git status
local function git_status()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
  if branch == "" then
    return "No Git Repo"
  end

  local changes = vim.fn.system("git status -s 2>/dev/null")
  local count = select(2, changes:gsub("\n", ""))
  return " " .. branch .. "  •  " .. count .. " changes"
end

-- Lazy.nvim startup stats
local function get_launch_stats()
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    return " Plugins loaded"
  end
  local stats = lazy.stats()
  local ms = math.floor(stats.startuptime * 100) / 100
  return string.format(" %d plugins loaded in %sms", stats.count, ms)
end

-- Header (R NVIM 3D-style)
local header = {
  "  ██████╗     ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
  "  ██╔══██╗    ████╗  ██║██║   ██║██║████╗ ████║",
  "  ██████╔╝    ██╔██╗ ██║██║   ██║██║██╔████╔██║",
  "  ██╔══██╗    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "  ██║  ██║    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "  ╚═╝  ╚═╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

-- Menu entries
local menu = {
  { icon = "",  text = "Find File",         key = "f", cmd = "Telescope find_files" },
  { icon = "",  text = "New File",          key = "n", cmd = "enew" },
  { icon = "",  text = "Recent Files",      key = "r", cmd = "Telescope oldfiles" },
  { icon = "",  text = "Find Text",         key = "g", cmd = "Telescope live_grep" },
  { icon = "",  text = "Edit Config",       key = "c", cmd = "edit ~/.config/nvim/init.lua" },
  { icon = "",  text = "Open Last Session", key = "s", cmd = "source Session.vim" },
  { icon = "󰒲",  text = "Lazy Menu",         key = "l", cmd = "Lazy" },
  { icon = "",  text = "Search Plugins",    key = "p", cmd = "lua require('core.plugin_search').open()" },
  { icon = "󰒰",  text = "LeetCode",          key = "t", cmd = "Leet" },
  { icon = "",  text = "Quit",              key = "q", cmd = "qa" },
}

-- Display width helper (handles nerd fonts)
local function visual_len(str)
  return vim.fn.strdisplaywidth(str)
end

-- Center a string in the window
local function center(str)
  local win_width = vim.o.columns
  local pad = math.floor((win_width - visual_len(str)) / 2)
  if pad < 0 then
    pad = 0
  end
  return string.rep(" ", pad) .. str
end

-- Create empty buffer skeleton
local function make_empty()
  local total = #header + (#menu * 2) + 14
  local pad_top = math.floor((vim.o.lines - total) / 2)
  local lines = {}
  for _ = 1, pad_top do
    table.insert(lines, "")
  end
  for _ = 1, total do
    table.insert(lines, "")
  end
  return lines, pad_top
end

-- Header animation (still lightweight)
local function animate_header(buf, pad_top)
  local i = 1
  local function step()
    if not api.nvim_buf_is_valid(buf) then
      return
    end
    if i > #header then
      return
    end
    vim.bo[buf].modifiable = true
    api.nvim_buf_set_lines(buf, pad_top + i, pad_top + i + 1, false, { center(header[i]) })
    vim.bo[buf].modifiable = false
    i = i + 1
    vim.defer_fn(step, 10) -- reduce if you want even faster (e.g. 5)
  end
  step()
end

-- Positions for per-line highlight
local menu_positions = {}

-- Render status lines + menu
local function render_menu(buf, pad_top)
  menu_positions = {}

  local row = pad_top + #header + 4
  vim.bo[buf].modifiable = true

  -- Greeting
  api.nvim_buf_set_lines(buf, row, row + 1, false, { center(get_greeting()) })
  row = row + 2

  -- Weather (optional)
  local ok_weather, weather_mod = pcall(require, "core.weather")
  if ok_weather and weather_mod.get_weather then
    local weather = weather_mod.get_weather()
    api.nvim_buf_set_lines(buf, row, row + 1, false, { center(weather) })
    row = row + 2
  end

  -- Git status
  api.nvim_buf_set_lines(buf, row, row + 1, false, { center(git_status()) })
  row = row + 2

  -- Launch stats
  api.nvim_buf_set_lines(buf, row, row + 1, false, { center(get_launch_stats()) })
  row = row + 2

  -- System stats
  api.nvim_buf_set_lines(buf, row, row + 1, false, { center(system.get_system_stats()) })
  row = row + 2

  

  -- Menu entries
  for _, m in ipairs(menu) do
    local left = string.format("%s  %-50s", m.icon, m.text)
    local right = string.format("[%s]", m.key)
    local composed = left .. "    " .. right
    local line = center(composed)

    api.nvim_buf_set_lines(buf, row, row + 1, false, { line })

    local first = line:find("%S") or 1
    local last_byte = line:match(".*%S()") or (#line + 1)

    table.insert(menu_positions, {
      row = row,
      col_start = first - 1,   -- 0-based
      col_end = last_byte - 1, -- end_col exclusive
    })

    row = row + 2
  end

  -- Clock at bottom
  api.nvim_buf_set_lines(buf, row + 1, row + 2, false, { center(get_clock()) })

  vim.bo[buf].modifiable = false
end

-- Open dashboard (NO outer defer_fn → instant load)
function M.open()
  vim.cmd("enew")
  local buf = api.nvim_get_current_buf()

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false

  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = "no"
  vim.wo.cursorline = false
  vim.wo.wrap = false
  vim.wo.scrolloff = 99999

  -- Disable insert on dashboard
  for _, key in ipairs({ "i", "a", "o", "O", "I", "A" }) do
    vim.keymap.set("n", key, "<nop>", { buffer = buf })
  end

  local lines, pad_top = make_empty()
  vim.bo[buf].modifiable = true
  api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  -- Draw immediately
  animate_header(buf, pad_top)
  render_menu(buf, pad_top)

  -- Keymaps + highlight logic
  local ns = api.nvim_create_namespace("rnvim_dash")
  local current = 1

  local function highlight(idx)
    api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    local pos = menu_positions[idx]
    if not pos then
      return
    end
    api.nvim_buf_add_highlight(
      buf,
      ns,
      "Visual",
      pos.row,
      pos.col_start,
      pos.col_end
    )
  end

  highlight(1)

  local opts = { noremap = true, silent = true, buffer = buf }

  local function move_down()
    current = math.min(#menu, current + 1)
    highlight(current)
  end

  local function move_up()
    current = math.max(1, current - 1)
    highlight(current)
  end

  vim.keymap.set("n", "j", move_down, opts)
  vim.keymap.set("n", "<Down>", move_down, opts)
  vim.keymap.set("n", "k", move_up, opts)
  vim.keymap.set("n", "<Up>", move_up, opts)

  vim.keymap.set("n", "<CR>", function()
    vim.cmd(menu[current].cmd)
  end, opts)

  for _, m in ipairs(menu) do
    vim.keymap.set("n", m.key, function()
      vim.cmd(m.cmd)
    end, opts)
  end
end

return M
