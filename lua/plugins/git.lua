local mapkey = require("util.keymapper").mapkey

return {
	{
		"kdheepak/lazygit.nvim",
		event = "VeryLazy",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		config = function()
			require("gitblame").setup({
				delay = 200,
				enabled = true,
				date_format = "%d/%m/%Y",
				message_when_not_committed = "Oh please, commit this !",
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		dependencies = {
			"tpope/vim-rhubarb",
		},
		event = "VeryLazy",
		keys = {
			mapkey("<leader>gs", "Git", "n"),
		},
		config = function()
			vim.keymap.set("n", "<leader>ha", "<CMD>GBrowse<CR>", { desc = "Git: Open in browser" })
			vim.keymap.set("v", "<leader>ha", ":'<,'>GBrowse<CR>", { desc = "Git: Open in browser" })
			vim.keymap.set("n", "<leader>hA", "<CMD>GBrowse!<CR>", { desc = "Git: URL to clipboard" })
			vim.keymap.set("v", "<leader>hA", ":'<,'>GBrowse!<CR>", { desc = "Git: URL to clipboard" })
			local CamiloAvelar_Fugitive = vim.api.nvim_create_augroup("CamiloAvelar_Fugitive", {})
			local autocmd = vim.api.nvim_create_autocmd
			autocmd("BufWinEnter", {
				group = CamiloAvelar_Fugitive,
				pattern = "*",
				callback = function()
					if vim.bo.ft ~= "fugitive" then
						return
					end

					local bufnr = vim.api.nvim_get_current_buf()
					local opts = { buffer = bufnr, remap = false }

					vim.keymap.set("n", "<leader>p", ":Git push -u origin ", opts)
					vim.keymap.set("n", "<leader>c", ":Git commit -m '", opts)
				end,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				current_line_blame_opts = {
					delay = 200,
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end)

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end)

					-- Actions
					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git: Stage hunk" })
					map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git: Reset hunk" })
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Git: Stage hunk" })
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Git: Reset hunk" })
					map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git: Stage buffer" })
					map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Git: Undo stage hunk" })
					map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git: Reset buffer" })
					map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git: Preview hunk" })
					map(
						"n",
						"<leader>hB",
						gitsigns.toggle_current_line_blame,
						{ desc = "Git: Toggle current line blame" }
					)
					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end, { desc = "Git: Blame line" })
					map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git: Diff this" })
					map("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end, { desc = "Git: Diff this (cached)" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
	{
		"polarmutex/git-worktree.nvim",
		version = "^2",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
