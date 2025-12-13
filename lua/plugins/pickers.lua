local mapkey = require("util.keymapper").mapkey

return {
	{
		"ibhagwan/fzf-lua",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		---@module "fzf-lua"
		---@type fzf-lua.Config|{}
		---@diagnostics disable: missing-fields
		opts = {
			"borderless-full",
			defaults = {
				formatter = "path.dirname_first",
			},
			fzf_opts = {
				["--cycle"] = true,
				["--marker"] = "+",
			},
			winopts = {
				---@diagnostic disable: missing-fields
				preview = {
					layout = "vertical",
					vertical = "down:25%",
					winopts = {
						number = false,
						flip_columns = 120,
						delay = 10,
					},
				},
				---@diagnostic enable: missing-fields
			},
			keymap = {
				builtin = {
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		},
		keys = {
			mapkey("<leader>pf", "FzfLua files", "n"),
			mapkey("<C-p>", "FzfLua git_files", "n"),
			mapkey("<leader>bl", "FzfLua buffers", "n"),
			mapkey("<leader>fk", "FzfLua keymaps", "n"),
			mapkey("<leader>hc", "FzfLua git_commits", "n", { desc = "Git: Commits" }),
			mapkey("<leader>fh", "FzfLua helptags", "n"),
			mapkey("<leader>fg", "FzfLua live_grep_native", "n"),
			mapkey("<leader>U", "FzfLua undotree", "n"),
			mapkey("<leader>fw", "FzfLua grep_cword", "n"),
			mapkey("<leader>fW", "FzfLua grep_cWORD", "n"),
			mapkey("<leader>fr", "FzfLua resume", "n"),
			mapkey("<leader>fb", "FzfLua buffers", "n"),
			mapkey("<leader>gb", "FzfLua git_branches", "n"),
			mapkey("<leader>fu", "FzfLua undotree", "n"),
		},
		---@diagnostics enable: missing-fields
	},
}
