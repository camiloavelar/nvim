-- auto-format on save
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		local efm = vim.lsp.get_active_clients({ name = "efm" })

		if vim.tbl_isempty(efm) then
			return
		end

		vim.lsp.buf.format({ name = "efm", async = true })
	end,
})

vim.cmd('highlight TreesitterContext guifg=#ffffff guibg=#131313')
vim.cmd('highlight TreesitterContextLineNumber guifg=#aaaaaa guibg=NONE')
vim.cmd('set cursorline')
vim.cmd('highlight CursorLineNr guifg=NONE guibg=NONE')
vim.cmd('highlight CursorLine guibg=#111111')
