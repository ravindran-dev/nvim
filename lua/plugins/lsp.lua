-- lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "SmiteshP/nvim-navic",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_cap = require("cmp_nvim_lsp").default_capabilities()

    local navic_ok, navic = pcall(require, "nvim-navic")

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = {
        "clangd",        -- C/C++
        "pyright",       -- Python
        "tsserver",      -- TS/JS
        "lua_ls",        -- Lua
        "gopls",         -- Go
        "rust_analyzer", -- Rust
      },
      automatic_installation = true,
    })

    local on_attach = function(client, bufnr)
      local map = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true })
      end

      -- basic LSP mappings
      map("n", "gd", vim.lsp.buf.definition)
      map("n", "K", vim.lsp.buf.hover)
      map("n", "<leader>rn", vim.lsp.buf.rename)

      -- breadcrumbs
      if navic_ok and client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

    local servers = {
      "clangd",
      "pyright",
      "tsserver",
      "lua_ls",
      "gopls",
      "rust_analyzer",
    }

    for _, server in ipairs(servers) do
      lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = cmp_cap,
      })
    end
  end,
}
