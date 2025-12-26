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

  view = {
    width = 32,
    side = "left",
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },

  renderer = {
    root_folder_label = false,
    highlight_git = true,

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
          unstaged  = "●",
          staged    = "",
          unmerged  = "",
          renamed   = "",
          untracked = "★",
          deleted   = "",
          ignored   = "◌",
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

  filters = {
    dotfiles = false, 
    git_clean = false,
    no_buffer = false,
    custom = {},
  },

  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },

  actions = {
    open_file = {
      quit_on_open = false,
    },
  },

  filesystem_watchers = {
    enable = true,
  },
})
