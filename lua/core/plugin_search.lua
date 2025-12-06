local M = {}

function M.open()
  local ok_t, telescope = pcall(require, "telescope")
  if not ok_t then
    vim.notify("Telescope is not installed", vim.log.levels.ERROR)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local lazy = require("lazy")

  local plugin_specs = lazy.plugins()

  local entries = {}
  local index = {}

  for name, spec in pairs(plugin_specs) do
    local display = string.format("%-28s  %s", name, spec[1] or spec.dir or "")
    table.insert(entries, display)
    index[display] = spec
  end

  pickers.new({}, {
    prompt_title = "R NVIM Plugins",
    finder = finders.new_table(entries),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local display = selection[1]
        local spec = index[display]
        if spec and spec.dir then
          vim.cmd("tabnew " .. spec.dir)
        else
          vim.notify("No directory for plugin", vim.log.levels.WARN)
        end
      end)
      return true
    end,
  }):find()
end

return M
