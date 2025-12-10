-- lua/core/tree.lua

local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
  return
end

nvimtree.setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,

  update_focused_file = {
    enable = true,
    update_root = true,
  },

  renderer = {
    highlight_git = true,
    root_folder_label = false,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "●",   -- modified but not staged
          staged   = "",   -- staged
          unmerged = "",
          renamed  = "",
          untracked = "★",  -- new file
          deleted  = "",
          ignored  = "◌",
        },
      },
    },
  },

  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },

  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },

  view = {
    width = 32,
    side = "left",
  },
})
