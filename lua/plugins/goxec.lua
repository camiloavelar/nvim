return {
	{
		dir = "~/personal/nvim-plugins/goexec.nvim",
		event = "VeryLazy",
		config = function()
			local goexec = require("GoExec")
			goexec:setup({
				window = {
					width = 155,
					height = 10,
				},
				jobs = {
					icon = " ",
				},
			})


			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { desc = "Go: " .. desc })
			end

			map("<leader>gg", "<cmd>GoExecToggle<CR>", "[G]o Exec")
		end,
	},
}
