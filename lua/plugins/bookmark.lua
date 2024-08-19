return {
	"tomasky/bookmarks.nvim",
	event = "VeryLazy",
	branch = "main",
	config = function()
		require("bookmarks").setup({
			-- sign_priority = 8,  --set bookmark sign priority to cover other sign
			save_file = vim.fn.expand("$HOME/.bookmarks"), -- bookmarks save file path
			keywords = {
				-- FIXME: find better signs
				["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
				["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
				["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
				["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
			},
			signs = {
				ann = { hl = "BookMarksAnn", text = "⚑", numhl = "BookMarksAnnNr", linehl = "BookMarksAnnLn" },
			},
			on_attach = function(_)
				local bm = require("bookmarks")
				local map = vim.keymap.set
				map("n", "<leader>mm", bm.bookmark_toggle, { desc = "Toogle bookmark" }) -- add or remove bookmark at current line
				map("n", "<leader>mi", bm.bookmark_ann, { desc = "Add bookmark" }) -- add or edit mark annotation at current line
				map("n", "<leader>mc", bm.bookmark_clean, { desc = "Clean bookmark on buffer" }) -- clean all marks in local buffer
				map("n", "<leader>mn", bm.bookmark_next, { desc = "Jump to next bookmark on buffer" }) -- jump to next mark in local buffer
				map("n", "<leader>mp", bm.bookmark_prev, { desc = "Jump to previous bookmark on buffer" }) -- jump to previous mark in local buffer
				map("n", "<leader>mL", bm.bookmark_list, { desc = "Show bookmarks on quickfix" }) -- show marked file list in quickfix window
				map("n", "<leader>ml", require("telescope").extensions.bookmarks.list, { desc = "Open bookmarks on Telescope" }) -- show marked file list in telescope
				map("n", "<leader>mx", bm.bookmark_clear_all, { desc = "Removes all bookmarks" }) -- removes all bookmarks
			end,
		})
	end,
}
