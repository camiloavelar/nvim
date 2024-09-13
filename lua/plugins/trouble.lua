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
					filter = { buf = 0, severity = vim.diagnostic.severity.ERROR },
				},
				workspace_diagnostics = {
					mode = "diagnostics",
					filter = {
						severity = vim.diagnostic.severity.ERROR,
					},
				},
			},
		})
		vim.keymap.set("n", "<leader>tt", function()
			require("trouble").toggle("document_diagnostics")
		end, { desc = "Trouble" })
		vim.keymap.set("n", "<leader>tw", function()
			require("trouble").toggle("workspace_diagnostics")
		end, { desc = "Trouble: Workspace Diagnostics" })
		vim.keymap.set("n", "<leader>td", function()
			require("trouble").toggle("document_diagnostics")
		end, { desc = "Trouble: Document Diagnostics" })
		vim.keymap.set("n", "<leader>tq", function()
			require("trouble").toggle("quickfix")
		end, { desc = "Trouble: Quickfix" })
		-- vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end, { desc = "Trouble: Loclist" })
		vim.keymap.set("n", "<leader>fD", function()
			require("trouble").toggle("lsp_references")
		end, { desc = "Trouble: LSP References" })
		vim.keymap.set("n", "<leader>tn", function()
			trouble.next("document_diagnostics", { new = false })
		end, { desc = "Trouble: Next" })
		vim.keymap.set("n", "<leader>tp", function()
			trouble.prev("document_diagnostics")
		end, { desc = "Trouble: Previous" })
	end,
}
