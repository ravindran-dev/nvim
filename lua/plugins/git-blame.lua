return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  config = function()
    
    vim.g.gitblame_enabled = 1

  
    vim.g.gitblame_display_virtual_text = 1
    vim.g.gitblame_virtual_text_position = "right_align" 

  
    vim.g.gitblame_highlight_group = "Comment"
  end,
}
