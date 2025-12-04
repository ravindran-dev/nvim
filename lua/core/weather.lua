local M = {}



M.get_weather = function()
  local api_key = "9769a872403d7fa41dbc16b62d33995b"
  local city = "chennai"
  local cmd = string.format("curl -s 'https://api.openweathermap.org/data/2.5/weather?q=%s&units=metric&appid=%s'", city, api_key)

  local handle = io.popen(cmd)
  if not handle then return "Weather ❌" end

  local result = handle:read("*a")
  handle:close()

  local temp = result:match('"temp":([%d%.]+)')
  local desc = result:match('"description":"(.-)"')

  if temp and desc then
    return string.format(" %s° C • %s", temp, desc)
  end

  return "Weather ❌"
end

return M
