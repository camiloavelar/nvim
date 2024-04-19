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
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
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
	})
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.3",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-symbols.nvim",
	},
	config = config,
	keys = {
		mapkey("<leader>fk", "Telescope keymaps", "n"),
		mapkey("<leader>fh", "Telescope help_tags", "n"),
		mapkey("<leader>pf", "Telescope find_files", "n"),
		mapkey("<C-p>", "Telescope git_files", "n"),
		mapkey("<leader>fg", "Telescope live_grep", "n"),
		mapkey("<leader>fb", "Telescope buffers", "n"),
		mapkey("<leader>bl", "Telescope buffers", "n"),
		mapkey("<leader>gc", "Telescope git_commits", "n"),
		mapkey("<leader>gb", "Telescope git_branches", "n"),
		mapkey("<leader>ts", "Telescope treesitter", "n"),
	},
}
