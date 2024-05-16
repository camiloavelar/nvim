return {
	"stevearc/resession.nvim",
	lazy = false,
	config = function()
		local resession = require("resession")
		resession.setup({})
		-- Resession does NOTHING automagically, so we have to set up some keymaps
		vim.keymap.set("n", "<leader>ss", resession.save)
		vim.keymap.set("n", "<leader>sl", resession.load)
		vim.keymap.set("n", "<leader>sd", resession.delete)

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				-- Only load the session if nvim was started with no args
				if vim.fn.argc(-1) == 0 or vim.fn.argv(0, -1) == "NvimTree_1" then
					-- Save these to a different directory, so our manual sessions don't get polluted
					resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
				end
			end,
			nested = true,
		})

		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
			end,
		})
	end,
}
