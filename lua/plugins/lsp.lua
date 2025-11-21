return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "b0o/schemastore.nvim",
  },

  config = function()

    local mason = require("mason")
    local mason_lsp = require("mason-lspconfig")

    mason.setup()

       local servers = {
      "pyright",
      "clangd",
      "ts_ls",
      "rust_analyzer",
      "gopls",
      "lua_ls",
      "jsonls",
      "html",
      "cssls",
    }

    mason_lsp.setup({
      ensure_installed = servers,
      automatic_installation = true,
    })


    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local function on_attach(_, bufnr)
      local map = function(lhs, rhs)
        vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
      end

      map("gd", vim.lsp.buf.definition)
      map("K",  vim.lsp.buf.hover)
      map("<leader>rn", vim.lsp.buf.rename)
      map("<leader>ca", vim.lsp.buf.code_action)
    end


    local custom = require("lsp.configs")


    for _, server in ipairs(servers) do
      local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      if custom[server] then
        opts = vim.tbl_deep_extend("force", opts, custom[server])
      end

      lspconfig[server].setup(opts)
    end
  end,
}
