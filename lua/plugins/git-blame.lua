return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  config = function()
    -- enable by default
    vim.g.gitblame_enabled = 1

    -- how it should look
    vim.g.gitblame_display_virtual_text = 1
    vim.g.gitblame_virtual_text_position = "right_align" -- or "eol"

    -- use Comment highlight group (subtle)
    vim.g.gitblame_highlight_group = "Comment"
  end,
}
