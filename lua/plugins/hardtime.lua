return {
	"m4xshen/hardtime.nvim",
	command = "Hardtime",
	lazy = false,
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	opts = {},
  config = {
    max_count = 4,
    allow_different_key = true
  }
}
