return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  keys = {
    {
      "tn",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next marked comment",
    },
    {
      "tN",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Prev marked comment",
    },
    {
      "<leader>ft",
      ":TodoTelescope<CR>",
      desc = "Search todo comments",
      silent = true,
    },
  },
  opts = {
    keywords = {
      FIX = { icon = " ", color = "#FF2D00", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "#FF8C00" },
      HACK = { icon = " ", color = "#3498DB", alt = { "MYTH" } },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      NOTE = { icon = " ", color = "#98C379", alt = { "INFO", "HINT" } },
    },
  },
}
