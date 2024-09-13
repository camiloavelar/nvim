return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {},
	event = "VeryLazy",
	config = function()
		vim.opt.list = true
		vim.opt.listchars:append("eol:⤦")
		vim.opt.listchars:append("trail:·")
		vim.opt.listchars:append("lead:·")
		vim.opt.listchars:append("tab:▎ ")

		require("ibl").setup({
			whitespace = {
				remove_blankline_trail = true,
			},
		})
	end,
}
