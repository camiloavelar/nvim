-- disable diagnostics for .env files
local lsp_grp = vim.api.nvim_create_augroup("lsp_disable", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile", "BufWinEnter" }, {
	group = lsp_grp,
	pattern = { "*.env", ".env.*" },
	callback = function()
		vim.diagnostic.disable(0)
	end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local view = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})
