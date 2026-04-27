return {
	"stevearc/resession.nvim",
	lazy = false,
	config = function()
		local resession = require("resession")
		resession.setup({
			buf_filter = function(bufnr)
				-- NOTE: saves only harpooned files
				local harpoon_files = require("harpoon"):list().items
				local buf_name = vim.fn.bufname(bufnr)
				local current_buf = vim.fn.bufname()

				if buf_name == current_buf then
					return true
				end

				for _, file in ipairs(harpoon_files) do
					if string.find(buf_name, file.value, 1, true) then
						return true
					end
				end

				return false
			end,
		})
		-- Resession does NOTHING automagically, so we have to set up some keymaps
		vim.keymap.set("n", "<leader>ss", resession.save, { desc = "Save Session" })
		vim.keymap.set("n", "<leader>sl", resession.load, { desc = "Load Session" })
		vim.keymap.set("n", "<leader>sd", resession.delete, { desc = "Delete Session" })

		local function get_session_name()
			local name = vim.fn.getcwd()
			local branch = vim.trim(vim.fn.system("git branch --show-current"))
			if vim.v.shell_error == 0 then
				return name .. branch
			else
				return name
			end
		end

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				-- Only load the session if nvim was started with no args
				if vim.fn.argc(-1) == 0 or vim.fn.argv(0, -1) == "NvimTree_1" then
					-- Save these to a different directory, so our manual sessions don't get polluted
					resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
				end
			end,
			nested = true,
		})

		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				resession.save(get_session_name(), { dir = "dirsession", notify = false })
			end,
		})
	end,
}
