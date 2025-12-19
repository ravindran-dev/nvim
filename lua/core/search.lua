local M = {}

local function is_dashboard()
  return vim.bo.filetype == "rnvim_dashboard" or vim.api.nvim_buf_get_name(0) == ""
end

function M.open_find_replace()
  local spectre = require("spectre")

  if is_dashboard() then
    -- Dashboard → full project search
    spectre.open({
      cwd = vim.loop.cwd(),
      search_dirs = { vim.loop.cwd() },
      is_insert_mode = true,
      disable_devicons = false,
    })
    return
  end

  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    spectre.open()
    return
  end

  local dir = vim.fn.fnamemodify(file, ":h")

  spectre.open({
    cwd = dir,
    search_dirs = { dir },
    is_insert_mode = true,
    disable_devicons = false,
  })
end

return M
