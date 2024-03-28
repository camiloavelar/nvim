return {
	"RRethy/vim-illuminate",
	lazy = false,
	config = function()
		require("illuminate").configure({})

    vim.keymap.set("n", "<leader>gn", require('illuminate').goto_next_reference, { desc = "Go to next word reference" })
    vim.keymap.set("n", "<leader>gp", require('illuminate').goto_prev_reference, { desc = "Go to prev word reference" })
	end,
}
