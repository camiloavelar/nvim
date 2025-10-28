return {
	{
		dir = "~/personal/nvim-plugins/goexec.nvim",
		event = "VeryLazy",
		config = function()
			local goexec = require("GoExec")
			goexec:setup({
				window = {
					width = 155,
					height = 10,
				},
				jobs = {
					icon = " ",
				},
			})

			local banking_work_dir = "/Users/camiloavelar/projects/banking"

			goexec:add_job({
				name = "BankingWeb",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/web/web",
			})
			goexec:add_job({
				name = "BankingIntranet",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/web/intranet",
			})
			goexec:add_job({
				name = "BalanceConsumer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/balance/internal/cmd",
				init_arg = "consumer",
			})
			goexec:add_job({
				name = "BalanceServer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/balance/internal/cmd",
				init_arg = "server",
			})
			goexec:add_job({
				name = "WorkflowDispatcher",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/workflowmanagement/internal/cmd",
				init_arg = "temporal-dispatcher",
			})
			goexec:add_job({
				name = "CardsGRPCServer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/cards/cmd/server/grpc",
			})
			goexec:add_job({
				name = "CardsAMQPServer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/cards/cmd/server/amqp",
				init_arg = "--nodeName=amqp-0",
			})
			goexec:add_job({
				name = "CardsConsumer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/cards/cmd/partition",
				init_arg = "--nodeName=consumer-0",
			})
			goexec:add_job({
				name = "LimitServer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/limit/internal/cmd",
				init_arg = "server",
			})
			goexec:add_job({
				name = "ConfigServer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/config/internal/cmd",
				init_arg = "server",
			})
			goexec:add_job({
				name = "ConnectWeb",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/web/connect/cmd/web",
				init_arg = "web",
			})
			goexec:add_job({
				name = "ConnectStatementConsumer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/connectstatement/internal/cmd",
				init_arg = "consumer",
			})
			goexec:add_job({
				name = "ConnectStatementServer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/connectstatement/internal/cmd",
				init_arg = "server",
			})
			goexec:add_job({
				name = "OperationConsumer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/operation/internal/cmd",
				init_arg = "consumer",
			})
			goexec:add_job({
				name = "OperationDispatcher",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/operation/internal/cmd",
				init_arg = "dispatcher",
			})
			goexec:add_job({
				name = "OperationServer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/operation/internal/cmd",
				init_arg = "server",
			})
			goexec:add_job({
				name = "GalileoAuth",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/galileoauth/internal/cmd",
				init_arg = "auth",
			})
			goexec:add_job({
				name = "GalileoDispatcherAuth",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/galileodispatcher/internal/cmd",
				init_arg = "auth",
			})
			goexec:add_job({
				name = "GalileoDispatcherEvents",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/galileodispatcher/internal/cmd",
				init_arg = "events",
			})
			goexec:add_job({
				name = "GalileoEvent",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/galileoauth/internal/cmd",
				init_arg = "event",
			})
			goexec:add_job({
				name = "GalileoEventsConsumer",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/galileoeventsconsumer/internal/cmd",
				init_arg = "consumer",
			})
			goexec:add_job({
				name = "GalileoTester",
				work_dir = banking_work_dir,
				package = "github.com/avenuesec/banking/internal/services/galileoauth/tester/cmd",
			})

			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { desc = "Go: " .. desc })
			end

			map("<leader>gg", "<cmd>GoExecToggle<CR>", "[G]o Exec")
		end,
	},
}
