local M = {}


M.in_dir = function(dir)
return vim.fn.isdirectory(vim.fn.expand(dir)) == 1
end


return M