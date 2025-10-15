-- Centralized diagnostic configuration
local M = {}

-- Diagnostic sign icons
M.signs = {
	text = {
		[vim.diagnostic.severity.ERROR] = " ",
		[vim.diagnostic.severity.WARN] = " ",
		[vim.diagnostic.severity.INFO] = "󰋼 ",
		[vim.diagnostic.severity.HINT] = "󰌵 ",
	},
	numhl = {
		[vim.diagnostic.severity.ERROR] = "",
		[vim.diagnostic.severity.WARN] = "",
		[vim.diagnostic.severity.HINT] = "",
		[vim.diagnostic.severity.INFO] = "",
	},
}

-- Setup function to configure diagnostics
function M.setup()
	vim.diagnostic.config({
		virtual_text = true,
		signs = M.signs,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
	})
end

return M
