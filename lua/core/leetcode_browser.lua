local M = {}
function M.get_cookie()
  local json = vim.fn.system("python3 ~/.config/nvim/scripts/get_leetcode_cookie.py")
  if json:find("ERROR") then return nil end
  return vim.fn.json_decode(json)
end
return M
