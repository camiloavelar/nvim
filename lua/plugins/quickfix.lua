return {
	{
		"kevinhwang91/nvim-bqf",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require("bqf").setup()
		end,
	},
	{
		"stevearc/qf_helper.nvim",
		event = "VeryLazy",
		enabled = false,
		opts = {},
	},
}
