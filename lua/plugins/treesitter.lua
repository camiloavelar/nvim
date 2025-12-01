local treesitter_config = function()
	require("nvim-treesitter").install({
		"markdown",
		"regex",
		"json",
		"javascript",
		"typescript",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"bash",
		"dockerfile",
		"gitignore",
		"python",
		"go",
	})

	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			local treesitter = require("nvim-treesitter")
			local lang = vim.treesitter.language.get_lang(args.match)
			if vim.list_contains(treesitter.get_available(), lang) then
				if not vim.list_contains(treesitter.get_installed(), lang) then
					treesitter.install(lang):wait()
				end
				vim.treesitter.start(args.buf)
			end
		end,
		desc = "Enable nvim-treesitter and install parser if not installed",
	})
end

local context_config = function()
	require("treesitter-context").setup({
		enable = true,
		max_lines = 3,
		multiline_threshold = 2,
	})
end

local textobjects_config = function()
	require("nvim-treesitter-textobjects").setup({
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	})
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = treesitter_config,
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = context_config,
			},
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				branch = "main",
				config = textobjects_config,
			},
		},
	},
}
