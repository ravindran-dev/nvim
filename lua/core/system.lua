local M = {}

-- Simple world clocks using UTC offsets (in hours)
local zones = {
  { name = "IST", offset = 5.5 },
  { name = "UTC", offset = 0 },
  { name = "PST", offset = -8 },
}

local function fmt_time(offset)
  local now = os.time()
  local seconds = offset * 3600
  local t = os.date("!*t", now + seconds)
  return string.format("%02d:%02d", t.hour, t.min)
end

function M.get_world_clock()
  local parts = {}
  for _, z in ipairs(zones) do
    table.insert(parts, string.format("%s %s", z.name, fmt_time(z.offset)))
  end
  return "  " .. table.concat(parts, "   •   ")
end

local function parse_cpu_temp(output)
  for line in output:gmatch("[^\r\n]+") do
    local temp = line:match("(%d+%.?%d*)°C")
    if temp then
      return temp
    end
  end
  return nil
end

function M.get_system_stats()
  local ok, out = pcall(vim.fn.system, "sensors 2>/dev/null | grep -m1 'Tctl\\|Tdie\\|Package id 0\\|CPU Temperature\\|temp1'")
  local cpu = ok and parse_cpu_temp(out) or nil

  local kb = collectgarbage("count")
  local mb = math.floor(kb / 1024 * 100) / 100

  if cpu then
    return string.format("󰍛 CPU: %s°C    Lua: %.2f MB", cpu, mb)
  else
    return string.format(" Lua: %.2f MB", mb)
  end
end

return M
