return {
	"epwalsh/obsidian.nvim",
	version = "*",
	event = "VeryLazy",
	ft = "markdown",
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
			workspaces = {
				{
					name = "work",
					path = "~/Documents/Obsidian/work",
				},
			},
			daily_notes = {
				folder = "notes/dailies",
			},
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
		})

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = "Obsidian: " .. desc })
		end

		map("<leader>ot", "<cmd>ObsidianToday<CR>", "Today")
		map("<leader>on", "<cmd>ObsidianNew<CR>", "New")
		map("<leader>oT", "<cmd>ObsidianTomorrow<CR>", "Tomorrow")
		map("<leader>os", "<cmd>ObsidianSearch<CR>", "Search")
		map("<leader>od", "<cmd>ObsidianDailies -7 1<CR>", "Dailies")
		map("<leader>of", "<cmd>ObsidianFollowLink<CR>", "FollowLink")
		map("<leader>or", "<cmd>ObsidianRename<CR>", "Rename")
		map("<leader>ol", "<cmd>ObsidianQuickSwitch<CR>", "List")

	end,
}
