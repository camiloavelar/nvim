-- auto-format on save
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
		local efm = vim.lsp.get_active_clients({ name = "efm", bufnr = bufnr })

		if vim.tbl_isempty(efm) then
			return
		end

		vim.lsp.buf.format({ name = "efm", async = true })
	end,
})

-- disable diagnostics for .env files
local lsp_grp = vim.api.nvim_create_augroup("lsp_disable", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile", "BufWinEnter"}, {
  group = lsp_grp,
  pattern = {"*.env", ".env.*"},
  callback = function()
    vim.diagnostic.disable(0)
  end
})
