return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				filetypes = { ["*"] = true },
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "VeryLazy",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"zbirenbaum/copilot.lua",
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		event = "VeryLazy",
		keys = {
			{
				"<leader>cc",
				"<cmd>CopilotChatToggle<CR>",
				desc = "Toggle Copilot Chat",
				mode = { "v", "n" },
			},
			{
				"<leader>ce",
				"<cmd>CopilotChatExplain<CR>",
				desc = "Copilot Explain Code",
				mode = { "v", "n" },
			},
			{
				"<leader>cd",
				"<cmd>CopilotChatDocs<CR>",
				desc = "Copilot Generate Documentation",
				mode = { "v", "n" },
			},
		},
		config = function()
			local chat = require("CopilotChat")
			chat.setup({
				auto_insert_mode = true,
				highlight_headers = false,
				window = { width = 0.4 },
				mappings = {
					complete = { insert = "<Tab>" },
					close = { normal = "<C-c>", insert = "<C-q>" },
					show_diff = { full_diff = false },
				},
			})

			vim.keymap.set("n", "<leader>cq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, {
						selection = require("CopilotChat.select").buffer,
					})
				end
			end, { desc = "CopilotChat - Quick chat" })

			vim.keymap.set("n", "<leader>cg", function()
				local input = vim.fn.input("Quick Generate Chat: ", "/COPILOT_GENERATE ")
				if input ~= "" then
					require("CopilotChat").ask(input, {
						selection = require("CopilotChat.select").buffer,
					})
				end
			end, { desc = "CopilotChat - Quick chat" })

			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				chat.reset()
				chat.toggle({
					window = { layout = "float" },
				})
			end, { noremap = true, silent = true, desc = "Toggle Copilot Floating Chat" })
		end,
	},
}
