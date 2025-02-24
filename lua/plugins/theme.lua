function PresentationMode()
	vim.cmd("set background=light")
	vim.cmd("colorscheme zenbones")
end

function DefaultMode()
	vim.cmd("set background=dark")
	vim.cmd("colorscheme catppuccin-mocha")
end

---@class MyColors<T>: {black: T, green: T, text: T, teal2: T, pink3: T, peach: T, blueGray1: T, blueGray2: T, teal1: T, blue1: T, blue2: T, blue3: T, yellow: T, overlay2: T, subtext0: T, background3: T}

return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				override = {
					go = {
						icon = "󰟓",
						color = "#00ADD8",
						name = "Go",
					},
				},
			})
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				term_colors = false,
				highlight_overrides = {
					---@param colors MyColors<string>
					---@return { [string]: {} }
					mocha = function(colors)
						return {
							Cursor = { bg = colors.green, fg = colors.black },
							iCursor = { bg = colors.green, fg = colors.black },

							Constant = { fg = colors.text },
							String = { fg = colors.teal2 },
							Character = { fg = colors.pink3 },
							Number = { fg = colors.peach },
							Boolean = { fg = colors.peach },
							Float = { fg = colors.peach },
							Identifier = { fg = colors.blueGray1 },
							Function = { fg = colors.teal1 },
							Statement = { fg = colors.text },
							Conditional = { fg = colors.blueGray1 },
							Repeat = { fg = colors.blue3 },
							Label = { fg = colors.text },
							Operator = { fg = colors.blue2 },
							Keyword = { fg = colors.blue2 },
							Exception = { fg = colors.blue3 },
							PreProc = { fg = colors.text },
							Include = { fg = colors.blueGray1 },
							Define = { fg = colors.yellow },
							Macro = { fg = colors.yellow },
							PreCondit = { fg = colors.yellow },
							Type = { fg = colors.blueGray2 },
							StorageClass = { fg = colors.overlay2 },
							Structure = { fg = colors.subtext0 },
							Special = { fg = colors.overlay2 },
							SpecialChar = { fg = colors.overlay2 },
							Folded = { fg = colors.blueGray2, bg = colors.background3 },
							RenderMarkdownCode = { bg = colors.background3 },

							TSProperty = { fg = colors.blueGray1 },
							TSVariable = { fg = colors.text },
							TSFunction = { fg = colors.blue2 },
							TSReturn = { fg = colors.blue1 },

							["@property"] = { link = "TSProperty" },
							["@parameter"] = { fg = colors.text },
							["@module"] = { fg = colors.text },
							["@type"] = { link = "Type" },
							["@type.builtin"] = { link = "Type" },
							["@variable.parameter"] = { fg = colors.text },
							["@variable.member"] = { link = "TSVariable" },
							["@keyword.function"] = { link = "TSFunction" },
							["@keyword.return"] = { link = "TSReturn" },
							["@function.builtin"] = { fg = colors.blue2 },
							["@function"] = { link = "Function" },
							["@function.call"] = { link = "Function" },
							["@constant.builtin"] = { fg = colors.peach },
							["@constant.falsy"] = { fg = colors.pink3 },
						}
					end,
				},
				color_overrides = {
					mocha = {
						green = "#5DE4C7",
						subtext1 = "#cdd6f4",
						yellow = "#806F2D",
						teal1 = "#5DE4C7",
						teal2 = "#5FB3A1",
						teal3 = "#42675A",
						blue1 = "#89DDFF",
						blue2 = "#93C1EC",
						blue3 = "#91B4D5",
						blue4 = "#7390AA",
						pink1 = "#FAE4FC",
						pink2 = "#FCC5E9",
						pink3 = "#D0679D",
						peach = "#fab387",
						blueGray1 = "#A6ACCD",
						blueGray2 = "#8087AF",
						blueGray3 = "#506477",
						background1 = "#303340",
						background2 = "#1B1E28",
						background3 = "#171922",
						text = "#cdd6f4",
						white = "#FFFFFF",
						none = "NONE",
						base = "#000000",
						mantle = "#000000",
						crust = "#000000",
					},
				},
			})

			vim.api.nvim_create_user_command("PresentationMode", function()
				PresentationMode()
			end, {})

			vim.api.nvim_create_user_command("DefaultMode", function()
				DefaultMode()
			end, {})
		end,
		init = function()
			DefaultMode()
		end,
	},
	{
		"zenbones-theme/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		-- you can set set configuration options here
		-- config = function()
		--     vim.g.zenbones_darken_comments = 45
		--     vim.cmd.colorscheme('zenbones')
		-- end
	},
}
