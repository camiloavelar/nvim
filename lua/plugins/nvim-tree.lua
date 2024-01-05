local width_ratio = 0.5
local height_ratio = 0.8
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-c>', api.tree.close,        opts('Close'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		require("nvim-tree").setup({
      on_attach = my_on_attach,
      hijack_netrw = false,
			filters = {
				dotfiles = false,
			},
      actions = {
        open_file = {
          quit_on_open = true
        }
      },
			view = {
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()

            local window_w = screen_w * width_ratio
            local window_h = screen_h * height_ratio
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
				adaptive_size = false,
        relativenumber = true,
			},
		})
	end,
}
