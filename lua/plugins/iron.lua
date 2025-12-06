local iron = require("iron.core")

iron.setup({
  config = {
    repl_definition = {
      python = {
        command = { "python" },
      },
      javascript = {
        command = { "node" },
      },
      lua = {
        command = { "lua" },
      },
      sh = {
        command = { "bash" },
      },
    },
    repl_open_cmd = "botright 15split", -- bottom split REPL
  },
  keymaps = {
    send_motion = "<leader>sc",
    visual_send = "<leader>sc",
    send_file = "<leader>sf",
    send_line = "<leader>sl",
    cr = "<leader>s<cr>",
    interrupt = "<leader>si",
    exit = "<leader>sq",
    clear = "<leader>cl",
  },
  highlight = { italic = true },
})

-- open REPL for current filetype
vim.keymap.set("n", "<leader>ir", function()
  iron.repl_for(vim.bo.filetype)
end, { desc = "Open REPL for current filetype" })

-- quickly send current line / selection
vim.keymap.set("n", "<leader>sl", iron.send_line, { desc = "Send line to REPL" })
vim.keymap.set("v", "<leader>sc", iron.visual_send, { desc = "Send selection to REPL" })
