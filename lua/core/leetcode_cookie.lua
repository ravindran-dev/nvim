local M = {}

function M.get_browser_cookie()
  local browser_cookie = vim.fn.system("python3 ~/.config/nvim/scripts/get_leetcode_cookie.py")

  if browser_cookie == "" or browser_cookie:find("ERROR") then
    return nil, "❌ Failed to read cookie from browser."
  end

  return browser_cookie
end

return M
