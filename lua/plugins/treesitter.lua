local config = function()
	require("nvim-treesitter.configs").setup({
		build = ":TSUpdate",
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		ensure_installed = {
			"markdown",
			"jsonc",
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
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
		textobjects = {
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
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-s>",
				node_incremental = "<C-s>",
				scope_incremental = false,
				node_decremental = "<BS>",
			},
		},
	})
end

local context_config = function()
	require("treesitter-context").setup({
		enable = true,
		max_lines = 3,
		multiline_threshold = 2,
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufEnter",
	config = config,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-context", config = context_config },
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}
