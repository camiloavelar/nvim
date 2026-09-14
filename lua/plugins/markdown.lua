return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "copilot-chat" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown", "copilot-chat" },
				heading = {
					width = "block",
					backgrounds = {
						"None",
					},
				},
				code = {
					width = "block",
					left_pad = 2,
					right_pad = 10,
					min_width = 45,
					-- highlight = 'None',
					-- highlight_inline = 'None',
					below = "─",
				},
			})
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		ft = "markdown",
		enabled = true,
		cmd = { "ObsidianToday", "ObsidianNew", "ObsidianTomorrow", "ObsidianSearch", "ObsidianDailies", "ObsidianQuickSwitch" },
		-- ft-scoped so <leader>or / <leader>ol only shadow octo's mappings inside markdown
		keys = {
			{ "<leader>ot", "<cmd>ObsidianToday<CR>", ft = "markdown", desc = "Obsidian: Today" },
			{ "<leader>on", "<cmd>ObsidianNew<CR>", ft = "markdown", desc = "Obsidian: New" },
			{ "<leader>oT", "<cmd>ObsidianTomorrow<CR>", ft = "markdown", desc = "Obsidian: Tomorrow" },
			{ "<leader>os", "<cmd>ObsidianSearch<CR>", ft = "markdown", desc = "Obsidian: Search" },
			{ "<leader>od", "<cmd>ObsidianDailies -7 1<CR>", ft = "markdown", desc = "Obsidian: Dailies" },
			{ "<leader>of", "<cmd>ObsidianFollowLink<CR>", ft = "markdown", desc = "Obsidian: FollowLink" },
			{ "<leader>or", "<cmd>ObsidianRename<CR>", ft = "markdown", desc = "Obsidian: Rename" },
			{ "<leader>ol", "<cmd>ObsidianQuickSwitch<CR>", ft = "markdown", desc = "Obsidian: List" },
			{ "<leader>ob", "<cmd>ObsidianBacklinks<CR>", ft = "markdown", desc = "Obsidian: List Backlinks" },
		},
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("obsidian").setup({
				ui = {
					enable = false,
				},
				workspaces = {
					{
						name = "work",
						path = "~/Documents/Obsidian/Camilo",
					},
				},
				daily_notes = {
					folder = "notes/dailies",
				},
				completion = {
					nvim_cmp = false,
					min_chars = 2,
				},
			})
		end,
	},
}
