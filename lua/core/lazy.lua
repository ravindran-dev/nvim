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


  { "nvim-lua/plenary.nvim", lazy = true },


  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({ flavour = "mocha", transparent_background = false })
      vim.cmd("colorscheme catppuccin")
    end
  },
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
    end
  },
  {
    'voldikss/vim-floaterm',
    cmd = { "FloatermNew", "FloatermToggle" },
  },
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
    end
  },


  { "nvim-lualine/lualine.nvim", opts = {} },
  { "kyazdani42/nvim-web-devicons", lazy = true },
  { "akinsho/bufferline.nvim", version = "*", dependencies = "kyazdani42/nvim-web-devicons" },
  { "nvim-tree/nvim-tree.lua", cmd = { "NvimTreeToggle" }, dependencies = "kyazdani42/nvim-web-devicons" },


  { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" }, cmd = "Telescope" },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function() require("plugins.treesitter") end },


  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig", config = function() require("plugins.lsp") end },


  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    config = function() require("plugins.cmp") end
  },
  { "L3MON4D3/LuaSnip", opts = {} },


  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function() require("plugins.null-ls") end,
    dependencies = { "nvim-lua/plenary.nvim" }
  },


  { "lewis6991/gitsigns.nvim", opts = {} },


  { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }, opts = {} },
  { "rcarriga/nvim-notify" },


  { "mfussenegger/nvim-dap", lazy = true },


  { "b0o/SchemaStore.nvim", lazy = true },
  { "simrat39/rust-tools.nvim", ft = { "rust" }, lazy = true },

}, {
  ui = {
    border = "rounded"
  },
})
