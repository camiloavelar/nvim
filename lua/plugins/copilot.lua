return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				filetypes = {
					["*"] = true,
				},
				suggestion = {
					enabled = false,
				},
				panel = {
					enabled = false,
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "VeryLazy",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
		},
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		event = "VeryLazy",
		keys = {
			{
				"<leader>cc",
				"<cmd>CopilotChatToggle<CR>",
				desc = "Toggle Copilot Chat",
			},
		},
		config = function()
			local chat = require("CopilotChat")
			chat.setup({
				auto_insert_mode = true,
				context = "files:full",
				window = {
					width = 0.4,
				},
				mappings = {
					complete = {
						insert = "<Tab>",
					},
					close = {
						normal = "<C-c>",
						insert = "<C-q>",
					},
				},
			})

			vim.keymap.set("n", "<leader>cf", function()
				chat.toggle({
					window = {
						layout = "float",
					},
				})
			end, { noremap = true, silent = true, desc = "Toggle Copilot Floating Chat" })
		end,
	},
}
