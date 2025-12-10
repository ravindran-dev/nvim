-- core/lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Core deps
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },

  -- Markdown preview
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = true,
  },

  -- Breadcrumbs
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    dependencies = { "neovim/nvim-lspconfig" },
  },

  -- Images in terminal
  {
    "3rd/image.nvim",
    lazy = false,
    config = function()
      require("image").setup({
        backend = "kitty",
        integrations = {},
        max_width = 60,
        max_height = 40,
        max_depth = nil,
        window_overlap_clear_enabled = true,
        editor_only_render_when_focused = true,
      })
    end,
  },

  -- Floaterm (legacy)
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle" },
  },

  -- Toggleterm (modern terminal)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = {
          border = "rounded",
        },
        size = 15,
      })
    end,
  },

  -- LeetCode
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("leetcode").setup({
        arg = "leetcode",
        lang = "python3",
        storage = {
          home = vim.fn.expand("~/.leetcode"),
        },
      })
    end,
  },

  -- UI: statusline, icons, bufferline
  { "nvim-lualine/lualine.nvim", opts = {} },
  { "kyazdani42/nvim-web-devicons", lazy = true },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "kyazdani42/nvim-web-devicons",
  },

  -- File explorer (single, correct definition)
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("core.tree")
    end,
  },


  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- LSP stack
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins.cmp")
    end,
  },
  { "L3MON4D3/LuaSnip", opts = {} },

  -- Inline git blame
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0
    end,
  },

  -- Sessions (for Open Last Session in dashboard)
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
    },
  },

  -- REPL panel
  {
    "Vigemus/iron.nvim",
    config = function()
      require("plugins.iron")
    end,
  },

  -- Formatting / linting bridge
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.null-ls")
    end,
  },

  -- Git signs in gutter
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- Fancy UI + notifications
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {},
  },
  { "rcarriga/nvim-notify" },

  -- DAP
  { "mfussenegger/nvim-dap", lazy = true },

  -- Extra schema / rust helpers
  { "b0o/SchemaStore.nvim", lazy = true },
  { "simrat39/rust-tools.nvim", ft = { "rust" }, lazy = true },

}, {
  ui = {
    border = "rounded",
  },
})
