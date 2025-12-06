
require('lualine').setup()
require('bufferline').setup{}
require('nvim-tree').setup({ view = { side = 'left' } })



require('telescope').setup{
defaults = { file_ignore_patterns = { 'node_modules' }, layout_strategy = 'flex' }
}
local navic_ok, navic = pcall(require, "nvim-navic")

require("lualine").setup({
  sections = {
    lualine_c = {
      { "filename" },
      navic_ok and {
        function()
          return navic.get_location()
        end,
        cond = function()
          return navic.is_available()
        end,
      } or nil,
    },
    -- keep your other sections
  },
})

