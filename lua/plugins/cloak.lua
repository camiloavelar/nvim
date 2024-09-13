return {
	"laytan/cloak.nvim",
	event = "BufEnter",
	config = function()
		require("cloak").setup({
			enabled = true,
			patterns = {
				{
					file_pattern = {
						".env*",
						"*.yaml",
					},
					cloak_pattern = {
						"=.+",
						"(_ID:).+",
						"(_TOKEN:).+",
						"(_SECRET:).+",
						"(_ID-).+",
						"(_TOKEN-).+",
						"(_SECRET-).+",
					},
				},
			},
		})
	end,
}
