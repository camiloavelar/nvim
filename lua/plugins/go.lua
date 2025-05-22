return {
	"ray-x/go.nvim",
	dev = false,
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			lsp_cfg = false,
			gofmt = "gofumpt",
			comment_placeholder = "",
			run_in_floaterm = true,
			lsp_inlay_hints = {
				enable = false,
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("go.nvim", { clear = true }),
			pattern = "*.go",
			callback = function(_)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { desc = "Go: " .. desc })
				end

				map("<leader>tf", "<cmd>GoTestFile -vF -C cov.out<CR>", "[T]est current [f]ile")
				map("<leader>tc", "<cmd>GoCoverage -t<CR>", "[T]est current file with [C]overage")
				map("<leader>tC", "<cmd>GoCoverage -f cov.out<CR>", "Load [T]est [C]overage file")
				map("<leader>tF", "<cmd>GoTestFunc -vF -C cov.out<CR>", "[T]est current [F]unction")
				map("<leader>ts", "<cmd>GoTestFunc -svF -C cov.out<CR>", "[T]est [s]elect functions")
				map("<leader>tP", "<cmd>GoTestPkg -vF -C cov.out<CR>", "Test package")
				map("<leader>fF", require("go.format").goimports, "[F]ormat buffer")
				map("<leader>ge", "<cmd>GoIfErr<CR>", "Add If[E]rr")
				map("<leader>gf", "<cmd>GoFillStruct<CR>", "[F]ill struct")
				map("<leader>ga", "<cmd>GoAddTest<CR>", "[A]dd test")
				map("<leader>gc", "<cmd>GoCmt<CR>", "[C]omment")
			end,
		})
	end,
	event = "VeryLazy",
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
