local mapkey = require("util.keymapper").mapkey

return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	branch = "main",
	keys = {
		mapkey("<leader><Tab>", "BufferLineCycleNext", "n"),
		mapkey("<leader>bc", "BufferLineCloseOthers", "n"),

		mapkey("<leader>0", "BufferLineGoToBuffer -1", "n"),
		vim.keymap.set("n", "<leader>E", function()
			if vim.o.showtabline == 1 then
				vim.o.showtabline = 2
			else
				vim.o.showtabline = 1
			end
		end, { desc = "Toggle bufferline" }),
	},
	config = function()
		vim.opt.showtabline = 2
		vim.opt.termguicolors = true
		vim.opt.mousemoveevent = true

		for i = 1, 9 do
			mapkey("<leader>b" .. i, "BufferLineGoToBuffer " .. i, "n")
		end

		local last_buff_name = ""
		require("bufferline").setup({
			options = {
				custom_filter = function(buf_number, _)
					local harpoon_files = require("harpoon"):list().items
					local buf_name = vim.fn.bufname(buf_number)
					local current_buf = vim.fn.bufname()
					local last_buff_id = vim.fn.bufnr("#")

					if last_buff_id ~= -1 then
						local last_buff_name_temp = vim.fn.bufname(last_buff_id)
						local last_buff_is_harpoon = false

						for _, file in ipairs(harpoon_files) do
							if string.find(last_buff_name_temp, file.value, 1, true) then
								last_buff_is_harpoon = true
							end
						end

						if not last_buff_is_harpoon then
							last_buff_name = last_buff_name_temp
						end
					end

					if buf_name == current_buf then
						return true
					end

					if buf_name == last_buff_name then
						local current_buf_is_harpoon = false

						for _, file in ipairs(harpoon_files) do
							if string.find(current_buf, file.value, 1, true) then
								current_buf_is_harpoon = true
							end
						end

						if current_buf_is_harpoon then
							return true
						end

						return false
					end

					for _, file in ipairs(harpoon_files) do
						if string.find(buf_name, file.value, 1, true) then
							return true
						end
					end

					return false
				end,
				numbers = function(opts)
					local harpoon_files = require("harpoon"):list().items
					local number = 0

					for i, file in ipairs(harpoon_files) do
						local bufname = vim.fn.bufname(opts.id)
						if string.find(bufname, file.value, 1, true) then
							number = i
						end
					end

					return string.format("%s·", number)
					-- return string.format('%s·%s', number, opts.raise(opts.ordinal))
				end,
				always_show_bufferline = false,
				auto_toggle_bufferline = false,
				sort_by = function(buffer_a, buffer_b)
					local harpoon_files = require("harpoon"):list().items
					local buff_a_number = 100
					local buff_b_number = 100

					for i, file in ipairs(harpoon_files) do
						local buf_a_name = vim.fn.bufname(buffer_a.id)
						local buf_b_name = vim.fn.bufname(buffer_b.id)
						if string.find(buf_a_name, file.value, 1, true) then
							buff_a_number = i
						end
						if string.find(buf_b_name, file.value, 1, true) then
							buff_b_number = i
						end
					end

					return buff_a_number < buff_b_number
				end,
				hover = {
					enabled = true,
					delay = 100,
					reveal = { "close" },
				},
				offsets = {
					{
						filetype = "NvimTree",
						text = "",
						highlight = "Directory",
						text_align = "center",
						separator = true,
					},
				},
			},
		})
	end,
}
