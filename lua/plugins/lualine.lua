vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local git_blame = require('gitblame')

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
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
      disabled_filetypes = {
        "NvimTree"
      }
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "buffers", max_length = vim.o.columns * 2 / 6 } },
      lualine_c = {
        { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
      },
			lualine_x = { "encoding", "fileformat", "filetype", lspStatus },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		tabline = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
