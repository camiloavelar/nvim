return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = {
		{ "<leader>da", function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle breakpoint" },
		{ "<leader>dt", function() require("dap").terminate() end, desc = "Debugger: Terminate" },
		{ "<leader>ds", function() require("dap").continue() end, desc = "Debugger: Continue/Start" },
		{ "<leader>do", function() require("dap").step_over() end, desc = "Debugger: Step over" },
		{ "<leader>di", function() require("dap").step_into() end, desc = "Debugger: Step into" },
		{ "<leader>dv", function() require("dap").step_out() end, desc = "Debugger: Step out" },
		{ "<leader>dc", function() require("dap").run_to_cursor() end, desc = "Debugger: Run to cursor" },
		{ "<leader>?", function() require("dapui").eval(nil, { enter = true }) end, desc = "Debugger: Eval under cursor" },
	},
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
	end,
}
