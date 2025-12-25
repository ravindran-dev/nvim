require("tokyonight").setup({
  style = "night", -- darkest base
  transparent = false,

  terminal_colors = true,

  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { bold = true },
    variables = {},
    sidebars = "dark",
    floats = "dark",
  },

  on_colors = function(colors)
    -- FORCE PURE BLACK BACKGROUND
    colors.bg = "#000000"
    colors.bg_dark = "#000000"
    colors.bg_float = "#000000"
    colors.bg_sidebar = "#000000"
    colors.bg_popup = "#000000"
    colors.bg_statusline = "#000000"

    -- Neon accents
    colors.blue = "#7aa2ff"
    colors.cyan = "#00ffff"
    colors.purple = "#bb9af7"
    colors.magenta = "#ff00ff"
    colors.green = "#00ff9c"
    colors.red = "#ff007c"
    colors.orange = "#ff9e64"
  end,
})

vim.cmd("colorscheme tokyonight")
