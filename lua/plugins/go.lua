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
	end,
	ft = { "go", "gomod" },
	-- Buffer-local to Go files; lazy sets these up without loading the plugin.
	keys = {
		{ "<leader>tf", "<cmd>GoTestFile -vF -C cov.out<CR>", ft = "go", desc = "Go: [T]est current [f]ile" },
		{ "<leader>tc", "<cmd>GoCoverage -t<CR>", ft = "go", desc = "Go: [T]est current file with [C]overage" },
		{ "<leader>tC", "<cmd>GoCoverage -f cov.out<CR>", ft = "go", desc = "Go: Load [T]est [C]overage file" },
		{ "<leader>tF", "<cmd>GoTestFunc -vF -C cov.out<CR>", ft = "go", desc = "Go: [T]est current [F]unction" },
		{ "<leader>ts", "<cmd>GoTestFunc -svF -C cov.out<CR>", ft = "go", desc = "Go: [T]est [s]elect functions" },
		{ "<leader>tP", "<cmd>GoTestPkg -vF -C cov.out<CR>", ft = "go", desc = "Go: Test package" },
		{
			"<leader>fF",
			function()
				require("go.format").goimports()
			end,
			ft = "go",
			desc = "Go: [F]ormat buffer",
		},
		{ "<leader>ge", "<cmd>GoIfErr<CR>", ft = "go", desc = "Go: Add If[E]rr" },
		{ "<leader>gf", "<cmd>GoFillStruct<CR>", ft = "go", desc = "Go: [F]ill struct" },
		{ "<leader>ga", "<cmd>GoAddTest<CR>", ft = "go", desc = "Go: [A]dd test" },
		{ "<leader>gc", "<cmd>GoCmt<CR>", ft = "go", desc = "Go: [C]omment" },
	},
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
