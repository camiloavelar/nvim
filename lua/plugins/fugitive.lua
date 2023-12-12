return {
  'tpope/vim-fugitive',
  lazy = false,
  config = function ()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

    local CamiloAvelar_Fugitive = vim.api.nvim_create_augroup("CamiloAvelar_Fugitive", {})
    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
      group = CamiloAvelar_Fugitive,
      pattern = "*",
      callback = function ()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}

        vim.keymap.set("n", "<leader>p", ":Git push -u origin ", opts);
        vim.keymap.set("n", "<leader>c", ":Git commit -m '", opts);
      end,
    })
  end,
}
