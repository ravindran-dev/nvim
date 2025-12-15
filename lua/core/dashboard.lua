local api = vim.api
local M = {}
local system = require("core.system")

local function open_last_session()
  local ok, persistence = pcall(require, "persistence")
  if not ok then
    vim.notify("persistence.nvim is not installed", vim.log.levels.ERROR)
    return
  end
  local buf = api.nvim_get_current_buf()
  if api.nvim_buf_is_valid(buf) then
    api.nvim_buf_delete(buf, { force = true })
  end
  persistence.load()
end

local function get_memory_usage()
  local kb = collectgarbage("count")
  local mb = math.floor(kb / 1024 * 100) / 100
  return string.format(" Lua memory: %.2f MB", mb)
end

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

local function get_clock()
  return os.date("  %I:%M %p     %d %b %Y")
end

local function git_status()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
  if branch == "" then
    return "No Git Repo"
  end
  local changes = vim.fn.system("git status -s 2>/dev/null")
  local count = select(2, changes:gsub("\n", ""))
  return " " .. branch .. "  •  " .. count .. " changes"
end

local function get_launch_stats()
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    return " Plugins loaded"
  end
  local stats = lazy.stats()
  local ms = math.floor(stats.startuptime * 100) / 100
  return string.format(" %d plugins loaded in %sms", stats.count, ms)
end

local function get_folder_info()
  local cwd = vim.fn.getcwd()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
  local root = (git_root ~= nil and git_root ~= "") and git_root or cwd
  local name = vim.fn.fnamemodify(root, ":t")

  local ok, items = pcall(vim.fn.globpath, root, "*", 0, 1)
  local count = ok and #items or 0

  local label
  if root == cwd then
    label = root
  else
    label = string.format("%s (cwd: %s)", root, cwd)
  end

  return string.format(" %s  • %d items  • %s", name, count, label)
end

local header = {
  "  ██████╗     ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
  "  ██╔══██╗    ████╗  ██║██║   ██║██║████╗ ████║",
  "  ██████╔╝    ██╔██╗ ██║██║   ██║██║██╔████╔██║",
  "  ██╔══██╗    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "  ██║  ██║    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "  ╚═╝  ╚═╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

local menu = {
  { icon = "",  text = "Find File",         key = "f", cmd = "Telescope find_files" },
  { icon = "",  text = "New File",          key = "n", cmd = "enew" },
  { icon = "",  text = "Recent Files",      key = "r", cmd = "Telescope oldfiles" },
  { icon = "",  text = "Find Text",         key = "g", cmd = "Telescope live_grep" },
  { icon = "",  text = "Edit Config",       key = "c", cmd = "edit ~/.config/nvim/init.lua" },
  { icon = "",  text = "Open Last Session", key = "s", action = open_last_session },
  { icon = "󰒲",  text = "Lazy Menu",         key = "l", cmd = "Lazy" },
  { icon = "",  text = "Search Plugins",    key = "p", cmd = "lua require('core.plugin_search').open()" },
  { icon = "󰒰",  text = "LeetCode",          key = "t", cmd = "Leet" },
  { icon = "",  text = "Quit",              key = "q", cmd = "qa" },
}

local function visual_len(str)
  return vim.fn.strdisplaywidth(str)
end

local function center(str)
  local win_width = vim.o.columns
  local pad = math.floor((win_width - visual_len(str)) / 2)
  if pad < 0 then
    pad = 0
  end
  return string.rep(" ", pad) .. str
end

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
    vim.defer_fn(step, 10)
  end
  step()
end

local menu_positions = {}

local function render_menu(buf, pad_top)
  menu_positions = {}
  local row = pad_top + #header + 4
  vim.bo[buf].modifiable = true

  api.nvim_buf_set_lines(buf, row, row + 1, false, { center(get_greeting()) })
  row = row + 2

  api.nvim_buf_set_lines(buf, row, row + 1, false, { center(get_folder_info()) })
  row = row + 2

  local ok_weather, weather_mod = pcall(require, "core.weather")
  if ok_weather and weather_mod.get_weather then
    local weather = weather_mod.get_weather()
    api.nvim_buf_set_lines(buf, row, row + 1, false, { center(weather) })
    row = row + 2
  end

  api.nvim_buf_set_lines(buf, row, row + 1, false, { center(git_status()) })
  row = row + 2

  api.nvim_buf_set_lines(buf, row, row + 1, false, { center(system.get_system_stats()) })
  row = row + 2

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
      col_start = first - 1,
      col_end = last_byte - 1,
    })

    row = row + 2
  end

  api.nvim_buf_set_lines(buf, row, row + 1, false, { center(get_launch_stats()) })
  row = row + 2

  api.nvim_buf_set_lines(buf, row, row + 1, false, { "" }) -- <-- blank space
  row = row + 1

  api.nvim_buf_set_lines(buf, row, row + 1, false, { center(get_clock()) })

  vim.bo[buf].modifiable = false
end

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
  for _, key in ipairs({ "i", "a", "o", "O", "I", "A" }) do
    vim.keymap.set("n", key, "<nop>", { buffer = buf })
  end

  local lines, pad_top = make_empty()
  vim.bo[buf].modifiable = true
  api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  animate_header(buf, pad_top)
  render_menu(buf, pad_top)

  local ns = api.nvim_create_namespace("rnvim_dash")
  local current = 1

  local function highlight(idx)
    api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    local pos = menu_positions[idx]
    if not pos then
      return
    end
    api.nvim_buf_add_highlight(buf, ns, "Visual", pos.row, pos.col_start, pos.col_end)
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
    local item = menu[current]
    if item.action then
      item.action()
    elseif item.cmd then
      vim.cmd(item.cmd)
    end
  end, opts)

  for _, m in ipairs(menu) do
    vim.keymap.set("n", m.key, function()
      if m.action then
        m.action()
      elseif m.cmd then
        vim.cmd(m.cmd)
      end
    end, opts)
  end
end

return M

