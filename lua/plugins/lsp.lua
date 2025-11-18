local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup()

mason_lsp.setup({
  ensure_installed = {
    "pyright",
    "clangd",
    "tsserver",
    "rust_analyzer",
    "gopls",
    "lua_ls",
  },
  automatic_installation = true,
})

local on_attach = function(client, bufnr)
  local bufmap = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end
  bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  "pyright",
  "clangd",
  "tsserver",
  "rust_analyzer",
  "gopls",
  "lua_ls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
