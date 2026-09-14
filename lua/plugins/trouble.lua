return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	keys = {
		{ "<leader>tt", function() require("trouble").toggle("document_diagnostics") end, desc = "Trouble: Document Diagnostics" },
		{ "<leader>tE", function() require("trouble").toggle("document_diagnostics_e") end, desc = "Trouble: Document Errors Diagnostics" },
		{ "<leader>ti", function() require("trouble").toggle("document_diagnostics_i") end, desc = "Trouble: Document Info Diagnostics" },
		{ "<leader>tw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "Trouble: Workspace Diagnostics (Warn, Error)" },
		{ "<leader>tn", function() require("trouble").next("document_diagnostics_e", { new = false }) end, desc = "Trouble: Next Error" },
		{ "<leader>tp", function() require("trouble").prev("document_diagnostics_e") end, desc = "Trouble: Previous Error" },
		{ "<leader>tN", function() require("trouble").next("document_diagnostics", { new = false }) end, desc = "Trouble: Next All" },
		{ "<leader>tP", function() require("trouble").prev("document_diagnostics") end, desc = "Trouble: Previous All" },
	},
	config = function()
		require("trouble").setup({
			modes = {
				document_diagnostics = {
					mode = "diagnostics",
					filter = { buf = 0 },
				},
				document_diagnostics_e = {
					mode = "diagnostics",
					filter = { buf = 0, severity = vim.diagnostic.severity.ERROR },
				},
				document_diagnostics_w = {
					mode = "diagnostics",
					filter = { buf = 0, severity = vim.diagnostic.severity.WARN },
				},
				document_diagnostics_i = {
					mode = "diagnostics",
					filter = { buf = 0, severity = vim.diagnostic.severity.INFO },
				},
				workspace_diagnostics = {
					mode = "diagnostics",
					filter = {
						severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
					},
				},
			},
		})
	end,
}
