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
			gofmt = "gofumpt",
			run_in_floaterm = true,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("go.nvim", { clear = true }),
			pattern = "*.go",
			callback = function(_)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { desc = "Go: " .. desc })
				end

				map("<leader>tf", "<cmd>GoTestFile -vF<CR>", "Test current file")
				map("<leader>tF", "<cmd>GoTestFunc -svF<CR>", "Test functions")
				map("<leader>tP", "<cmd>GoTestPkg -vF<CR>", "Test package")
				map("<leader>fF", require("go.format").goimports, "[F]ormat buffer")
				map("<leader>ge", "<cmd>GoIfErr<CR>", "Add If[E]rr")
				map("<leader>gf", "<cmd>GoFillStruct<CR>", "[F]ill struct")
			end,
		})
	end,
	event = "VeryLazy",
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
