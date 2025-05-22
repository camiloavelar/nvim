return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
	},
	event = "VeryLazy",
	config = function()
		require("dap-go").setup({
			dap_configurations = {
				{
					type = "go",
					name = "Debug server",
					request = "launch",
					program = "${file}",
					args = { "server" },
				},
			},
		})
		require("dapui").setup()
		require("nvim-dap-virtual-text").setup({})

		local dap, dapui = require("dap"), require("dapui")

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.disconnect["dapui_config"] = function()
			dapui.close()
		end

		local namespace = vim.api.nvim_create_namespace("dap-hlng")
		vim.api.nvim_set_hl(namespace, "DapBreakpoint", { fg = "#eaeaeb", bg = "#ffffff" })
		vim.api.nvim_set_hl(namespace, "DapLogPoint", { fg = "#eaeaeb", bg = "#ffffff" })
		vim.api.nvim_set_hl(namespace, "DapStopped", { fg = "#eaeaeb", bg = "#ffffff" })

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "•", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapLogPoint",
			{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
		)

		vim.keymap.set("n", "<leader>da", require("dap").toggle_breakpoint, { desc = "Debugger: Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dt", require("dap").terminate, { desc = "Debugger: Terminate" })
		vim.keymap.set("n", "<leader>ds", require("dap").continue, { desc = "Debugger: Continue/Start" })
		vim.keymap.set("n", "<leader>do", require("dap").step_over, { desc = "Debugger: Step over" })
		vim.keymap.set("n", "<leader>di", require("dap").step_into, { desc = "Debugger: Step into" })
		vim.keymap.set("n", "<leader>dv", require("dap").step_out, { desc = "Debugger: Step out" })
		vim.keymap.set("n", "<leader>dc", require("dap").run_to_cursor, { desc = "Debugger: Run to cursor" })
		vim.keymap.set("n", "<leader>?", function()
			require("dapui").eval(nil, { enter = true })
		end, { desc = "Debugger: Eval under cursor" })
	end,
}
