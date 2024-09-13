vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local git_blame = require("gitblame")

local lspStatus = {
	function()
		local msg = "No LSP detected"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = "",
	color = { fg = "#d3d3d3" },
}

local config = function()
	require("lualine").setup({
		options = {
			theme = "auto",
			globalstatus = true,
			component_separators = "|",
			section_separators = { right = "", left = "" },
			disabled_filetypes = {
				"NvimTree",
			},
		},
		sections = {
			lualine_a = {
				{
					"mode",
					icons_enabled = true,
					icon = "",
				},
			},
			lualine_b = {
				"diagnostics",
				"branch",
				{
					"filename",
					path = 0,
					symbols = {
						modified = "", -- Text to show when the file is modified.
						readonly = "󰌾", -- Text to show when the file is non-modifiable or readonly.
						unnamed = "No Name", -- Text to show for unnamed buffers.
						newfile = "New File", -- Text to show for newly created file before first write
					},
				},
			},
			lualine_c = {
				{
					git_blame.get_current_blame_text,
					cond = git_blame.is_blame_text_available,
					fmt = function(str, _)
						local maxLength = 80
						local strLen = string.len(str)
						local truncated = str:sub(0, maxLength)

						if strLen > maxLength then
							return truncated .. "..."
						end

						return truncated
					end,
				},
			},
			lualine_x = {
				{
					require("noice").api.statusline.mode.get,
					cond = require("noice").api.statusline.mode.has,
					color = { fg = "#ff9e64" },
				},
				"encoding",
				"fileformat",
				"filetype",
				lspStatus,
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		tabline = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = config,
}
