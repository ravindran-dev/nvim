local M = {}

M.lua_ls = {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

M.jsonls = {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = true,
    },
  },
}

M["ts_ls"] = {}

M.pyright = {}
M.clangd = {}
M.rust_analyzer = {}
M.gopls = {}
M.html = {}
M.cssls = {}

return M
