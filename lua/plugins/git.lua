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
				enabled = true,
				date_format = "%d/%m/%Y",
				message_when_not_committed = "Oh please, commit this !",
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		keys = {
			mapkey("<leader>gs", "Git", "n"),
		},
		config = function()
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
					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Gitsigns: Stage hunk" })
					map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Gitsigns: Reset hunk" })
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Gitsigns: Stage hunk" })
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Gitsigns: Reset hunk" })
					map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Gitsigns: Stage buffer" })
					map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Gitsigns: Undo stage hunk" })
					map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Gitsigns: Reset buffer" })
					map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Gitsigns: Preview hunk" })
					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end, { desc = "Gitsigns: Blame line" })
					map("n", "<leader>hd", gitsigns.diffthis, { desc = "Gitsigns: Diff this" })
					map("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end, { desc = "Gitsigns: Diff this (cached)" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
}
