return {
  'mbbill/undotree',
  lazy = false,
  config = function () 
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
  end,
}
