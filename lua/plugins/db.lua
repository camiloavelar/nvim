return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = "Go: " .. desc })
		end

		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_use_postgres_views = 0
		vim.g.db_ui_disable_progress_bar = 1
		vim.g.db_ui_win_position = "right"
		vim.g.db_ui_use_nvim_notify = 1

		map("<leader>db", "<cmd>DBUIToggle<CR>", "Toggle [DB]UI")
	end,
}
