local mapkey = require("util.keymapper").mapkey

local config = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
		},
		pickers = {
			git_files = {
				-- theme = "dropdown",
				previewer = true,
				hidden = false,
			},
			find_files = {
				-- theme = "dropdown",
				previewer = true,
				hidden = false,
			},
			live_grep = {
				-- theme = "dropdown",
				previewer = true,
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
	lazy = false,
	dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
	config = config,
	keys = {
		mapkey("<leader>fk", "Telescope keymaps", "n"),
		mapkey("<leader>ff", "Telescope harpoon marks", "n"),
		mapkey("<leader>fh", "Telescope help_tags", "n"),
		mapkey("<leader>pf", "Telescope find_files", "n"),
		mapkey("<C-p>", "Telescope git_files", "n"),
    mapkey("<leader>fd", "Telescope diagnostics", "n"),
		mapkey("<leader>fg", "Telescope live_grep", "n"),
		mapkey("<leader>fb", "Telescope buffers", "n"),
		mapkey("<leader>fs", "Telescope symbols", "n"),
		mapkey("<leader>gc", "Telescope git_commits", "n"),
		mapkey("<leader>gb", "Telescope git_branches", "n"),
	},
}
