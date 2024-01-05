return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function ()
    vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end, { desc = "Trouble" })
    vim.keymap.set("n", "<leader>tw", function() require("trouble").toggle("workspace_diagnostics") end, { desc = "Trouble: Workspace Diagnostics" })
    vim.keymap.set("n", "<leader>td", function() require("trouble").toggle("document_diagnostics") end, { desc = "Trouble: Document Diagnostics" })
    vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("quickfix") end, { desc = "Trouble: Quickfix" })
    vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end, { desc = "Trouble: Loclist" })
    vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, { desc = "Trouble: LSP References" })

    local CamiloAvelar_Trouble = vim.api.nvim_create_augroup("CamiloAvelar_Trouble", {})
    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
      group = CamiloAvelar_Trouble,
      pattern = "*",
      callback = function ()
        if vim.bo.ft ~= "noice" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()

        vim.keymap.set("n", "<leader>tn", function() require("trouble").next({ skip_groups = true, jump = true }) end, { buffer = bufnr, remap = false, desc = "Trouble: Next" })
        vim.keymap.set("n", "<leader>tp", function() require("trouble").previous({ skip_groups = true, jump = true }) end, { buffer = bufnr, remap = false, desc = "Trouble: Previous" })
      end,
    })
  end,
}
