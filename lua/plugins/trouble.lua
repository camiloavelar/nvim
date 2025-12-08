return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {},
	cmd = "Trouble",
	config = function()
		local trouble = require("trouble")
		trouble.setup({
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
		vim.keymap.set("n", "<leader>tt", function()
			require("trouble").toggle("document_diagnostics")
		end, { desc = "Trouble: Document Diagnostics" })
		vim.keymap.set("n", "<leader>tE", function()
			require("trouble").toggle("document_diagnostics_e")
		end, { desc = "Trouble: Document Errors Diagnostics" })
		vim.keymap.set("n", "<leader>ti", function()
			require("trouble").toggle("document_diagnostics_i")
		end, { desc = "Trouble: Document Info Diagnostics" })
		vim.keymap.set("n", "<leader>tw", function()
			require("trouble").toggle("workspace_diagnostics")
		end, { desc = "Trouble: Workspace Diagnostics (Warn, Error)" })
		vim.keymap.set("n", "<leader>tn", function()
			trouble.next("document_diagnostics_e", { new = false })
		end, { desc = "Trouble: Next Error" })
		vim.keymap.set("n", "<leader>tp", function()
			trouble.prev("document_diagnostics_e")
		end, { desc = "Trouble: Previous Error" })
		vim.keymap.set("n", "<leader>tN", function()
			trouble.next("document_diagnostics", { new = false })
		end, { desc = "Trouble: Next All" })
		vim.keymap.set("n", "<leader>tP", function()
			trouble.prev("document_diagnostics")
		end, { desc = "Trouble: Previous All" })
	end,
}
