local mapkey = require("util.keymapper").mapkey

local config = function()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")

	vim.keymap.set("n", "<leader>fw", function()
		local word = vim.fn.expand("<cword>")
		builtin.grep_string({ search = word })
	end, { desc = "Search for word under cursor" })

	vim.keymap.set("n", "<leader>fW", function()
		local word = vim.fn.expand("<cWORD>")
		builtin.grep_string({ search = word })
	end, { desc = "Search for full word under cursor" })

	telescope.setup({
		defaults = {
			history = {
				path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
				limit = 100,
			},
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
					["<C-n>"] = "cycle_history_next",
					["<C-p>"] = "cycle_history_prev",
				},
			},
			file_ignore_patterns = {
				".git/",
				"node_modules",
				"coverage",
				"dist",
				"build",
				"target",
				"vendor",
				"yarn.lock",
				"package-lock.json",
			},
			dynamic_preview_title = true,
		},
		pickers = {
			lsp_references = {
				previewer = true,
				hidden = true,
				show_line = false,
				-- file_ignore_patterns = {
				--   "%_test.*",
				--   "%_mock.*",
				--   "%mocks/*",
				-- },
			},
			lsp_implementations = {
				previewer = true,
				hidden = true,
				show_line = false,
				-- file_ignore_patterns = {
				--   "%_test.*",
				--   "%_mock.*",
				--   "%mocks/*",
				-- },
			},
			git_files = {
				previewer = true,
				hidden = true,
			},
			find_files = {
				previewer = true,
				hidden = true,
				no_ignore = true,
			},
			live_grep = {
				previewer = true,
				hidden = true,
				file_ignore_patterns = {
					"%_test.*",
					"%_mock.*",
					"%mocks/*",
				},
			},
			buffers = {
				-- theme = "dropdown",
				previewer = true,
			},
		},
		extensions = {
			frecency = {
				default_workspace = "CWD",
			},
			fzf = {},
			wrap_results = true,
		},
	})

	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "smart_history")
	pcall(require("telescope").load_extension, "frecency")
end

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-symbols.nvim",
		"nvim-telescope/telescope-smart-history.nvim",
		"nvim-telescope/telescope-frecency.nvim",
		"kkharji/sqlite.lua",
	},
	config = config,
	keys = {
		mapkey("<leader>fk", "Telescope keymaps", "n"),
		mapkey("<leader>fh", "Telescope help_tags", "n"),
		mapkey("<leader>pF", "Telescope frecency", "n"),
		mapkey("<leader>pf", "Telescope find_files", "n"),
		mapkey("<C-p>", "Telescope git_files", "n"),
		mapkey("<leader>fg", "Telescope live_grep", "n"),
		mapkey("<leader>fb", "Telescope buffers sort_mru=true", "n"),
		mapkey("<leader>bl", "Telescope buffers", "n"),
		mapkey("<leader>gc", "Telescope git_commits", "n"),
		mapkey("<leader>gb", "Telescope git_branches", "n"),
		mapkey("<leader>ts", "Telescope treesitter", "n"),
		mapkey("<leader>/", "Telescope current_buffer_fuzzy_find", "n"),
	},
}
