return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
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
			local trouble = require("trouble")

			if not trouble.is_open() then
				trouble.open("document_diagnostics")
			end

			trouble.next({ skip_groups = true, jump = true })
		end, { desc = "Trouble: Next" })
		vim.keymap.set("n", "<leader>tp", function()
			local trouble = require("trouble")

			if not trouble.is_open() then
				trouble.open("document_diagnostics")
			end

			require("trouble").previous({ skip_groups = true, jump = true })
		end, { desc = "Trouble: Previous" })
	end,
}
