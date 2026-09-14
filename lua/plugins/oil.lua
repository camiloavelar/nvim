return {
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = {
			{ "_", function() require("oil").toggle_float() end, desc = "Oil: toggle float" },
		},
		config = function()
			local oil = require("oil")

			oil.setup({
				columns = { "icon" },
				view_options = {
					show_hidden = true,
				},
				delete_to_trash = true, -- Deletes to trash
				skip_confirm_for_simple_edits = true,
				use_default_keymaps = false,
				float = {
					padding = 4,
					border = "rounded",
					max_width = 0.3,
					max_height = 0.7,
					win_options = {
						winblend = 0,
					},
				},
				keymaps = {
					["<CR>"] = "actions.select",
					["-"] = "actions.parent",
					["<C-c>"] = "actions.close",
				},
			})
		end,
	},
}
