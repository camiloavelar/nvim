return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			image = { enabled = true, terminal = "kitty" },
			input = { enabled = true },
			picker = { enabled = true },
			bufdelete = { enabled = true },
			quickfile = { enabled = true },
			indent = {
				enabled = true,
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
				"<leader>bd",
				function()
					Snacks.bufdelete.delete({ force = true })
				end,
				desc = "[B]uffer [D]elete",
			},
			{
				"<leader>bD",
				function()
					Snacks.bufdelete.other({ force = true })
				end,
				desc = "[B]uffer [D]elete Other",
			},
			{
				"<leader>bA",
				function()
					Snacks.bufdelete.all({ force = true })
				end,
				desc = "[B]uffer Delete [A]ll",
			},
			{
				"<leader>gn",
				function()
					Snacks.words.jump(1, true)
				end,
				desc = "[G]o to [N]ext word",
			},
			{
				"<leader>gp",
				function()
					Snacks.words.jump(-1, true)
				end,
				desc = "[G]o to [P]revious word",
			},
		},
	},
}
