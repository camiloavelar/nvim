return {
	"ThePrimeagen/harpoon",
	event = "VeryLazy",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		vim.keymap.set("n", "<leader>bb", "<CMD>e #<CR>", { desc = "Toggle last buffer" })

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon add file" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, function()
				harpoon:list():select(i)
			end, { desc = "Harpoon file " .. i })
		end

		harpoon:extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<C-c>", function()
					harpoon.ui:close_menu()
				end, { buffer = cx.bufnr })
			end,
			REMOVE = function(_)
				vim.cmd("doautocmd BufRead")
			end,
			ADD = function(_)
				vim.cmd("doautocmd BufRead")
			end,
		})
	end,
}
