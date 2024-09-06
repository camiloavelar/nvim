return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			lsp_cfg = false,
		})

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = "Go: " .. desc })
		end

		map("<leader>tF", "<cmd>GoTestFile<CR>", "Test current file")
		map("<leader>tf", "<cmd>GoTestFunc -s<CR>", "Test functions")
	end,
	event = "VeryLazy",
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
