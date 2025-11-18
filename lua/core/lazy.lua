-- core/lazy.lua

-- 1. Set lazy.nvim install path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 2. Bootstrap lazy.nvim if not installed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

-- 3. Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- 4. Setup lazy and plugin list
require("lazy").setup({

  -- utilities
  { "nvim-lua/plenary.nvim", lazy = true },

  -- colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({ flavour = "mocha", transparent_background = false })
      vim.cmd("colorscheme catppuccin")
    end
  },
  {
    "edluffy/hologram.nvim",
    config = function()
      require("hologram").setup{
        auto_display = true
      }
    end
  },
  -- UI
  { "nvim-lualine/lualine.nvim", opts = {} },
  { "kyazdani42/nvim-web-devicons", lazy = true },
  { "akinsho/bufferline.nvim", version = "*", dependencies = "kyazdani42/nvim-web-devicons" },
  { "nvim-tree/nvim-tree.lua", cmd = { "NvimTreeToggle" }, dependencies = "kyazdani42/nvim-web-devicons" },

  -- Telescope
  { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" }, cmd = "Telescope" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function() require("plugins.treesitter") end },

  -- LSP + mason
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig", config = function() require("plugins.lsp") end },

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    config = function() require("plugins.cmp") end
  },
  { "L3MON4D3/LuaSnip", opts = {} },

  -- Null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function() require("plugins.null-ls") end,
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Git
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- noice + notify
  { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }, opts = {} },
  { "rcarriga/nvim-notify" },

  -- DAP
  { "mfussenegger/nvim-dap", lazy = true },

  -- misc
  { "b0o/SchemaStore.nvim", lazy = true },
  { "simrat39/rust-tools.nvim", ft = { "rust" }, lazy = true },

}, {
  ui = {
    border = "rounded"
  },
})
