return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble" },
  config = true,
  -- stylua: ignore
  keys = {
    { "]t",         function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
    { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    { "<leader>wt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
    { "<leader>wT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
  },
}
