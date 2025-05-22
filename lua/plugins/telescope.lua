local mapkey = require("util.keymapper").mapkey

local config = function()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")
	local lga_actions = require("telescope-live-grep-args.actions")
	local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
	local live_grep_postfix = " --iglob !*_test* --iglob !*_mock.* --iglob !*.pb.go"

	vim.keymap.set("n", "<leader>fW", function()
		local word = vim.fn.expand("<cWORD>")
		builtin.grep_string({ search = word })
	end, { desc = "Search for full word under cursor" })

	vim.keymap.set("n", "<leader>fw", function()
		live_grep_args_shortcuts.grep_word_under_cursor({ postfix = live_grep_postfix })
	end, { desc = "Search for word under cursor" })

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
				file_ignore_patterns = {
					-- "%_test.*",
					"%_mock.*",
					"%mocks/*",
				},
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
					-- "%_test.*",
					"%_mock.*",
					"%mocks/*",
					"%.pb.go",
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
			live_grep_args = {
				auto_quoting = true, -- enable/disable auto-quoting
				-- define mappings, e.g.
				mappings = { -- extend mappings
					i = {
						["<C-t>"] = lga_actions.quote_prompt({ postfix = " --iglob !*_test.go --iglob !*_mock.*" }),
						["<C-h>"] = lga_actions.quote_prompt({ postfix = " --hidden" }),
						-- freeze the current list and start a fuzzy search in the frozen list
						["<C-space>"] = lga_actions.to_fuzzy_refine,
					},
				},
				-- ... also accepts theme settings, for example:
				-- theme = "dropdown", -- use dropdown theme
				-- theme = { }, -- use own theme spec
				-- layout_config = { mirror=true }, -- mirror preview pane
			},
		},
	})

	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "smart_history")
	pcall(require("telescope").load_extension, "frecency")
	pcall(require("telescope").load_extension, "git_worktree")
	pcall(require("telescope").load_extension, "bookmarks")
	pcall(require("telescope").load_extension, "live_grep_args")
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
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			version = "^1.0.0",
		},
	},
	config = config,
	keys = {
		mapkey("<leader>fk", "Telescope keymaps", "n"),
		mapkey("<leader>fh", "Telescope help_tags", "n"),
		mapkey("<leader>pF", "Telescope frecency", "n"),
		mapkey("<leader>pf", "Telescope find_files", "n"),
		mapkey("<C-p>", "Telescope git_files", "n"),
		mapkey(
			"<leader>fg",
			"lua require('telescope').extensions.live_grep_args.live_grep_args()",
			"n",
			{ desc = "Search for word" }
		),
		mapkey("<leader>fb", "Telescope buffers sort_mru=true", "n"),
		mapkey("<leader>bl", "Telescope buffers", "n"),
		mapkey("<leader>hc", "Telescope git_commits", "n", { desc = "Git: Telescope commits" }),
		mapkey("<leader>gb", "Telescope git_branches", "n"),
		mapkey("<leader>ts", "Telescope treesitter", "n"),
		mapkey("<leader>/", "Telescope current_buffer_fuzzy_find", "n"),
	},
}
