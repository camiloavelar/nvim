return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		event = "VeryLazy",
		---@type snacks.Config
		opts = {
			indent = {
				animate = {
					enabled = false,
				},
				chunk = {
					enabled = false,
					char = {
						corner_top = "╭",
						corner_bottom = "╰",
						vertical = "│",
						horizontal = "",
						arrow = "→",
						-- horizontal = "─",
						-- arrow = "─",
					},
				},
			},
			words = {
				enabled = true,
				debounce = 50,
				modes = { "n", "c" },
			},
		},
		keys = {
			{
				"<leader>gn",
				function()
					Snacks.words.jump(1, true)
				end,
				desc = "Next word",
			},
			{
				"<leader>gp",
				function()
					Snacks.words.jump(-1, true)
				end,
				desc = "Next word",
			},
		},
	},
}
