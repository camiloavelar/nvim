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
			-- Define custom colors
			local custom_colors = {
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
				base = "#000000",
				mantle = "#000000",
				crust = "#000000",
				black = "#000000",
				cursorline = "#1f202d",
			}

			require("catppuccin").setup({
				transparent_background = true,
				term_colors = false,
				highlight_overrides = {
					---@return { [string]: {} }
					mocha = function(colors)
						return {
							Cursor = { bg = custom_colors.green, fg = custom_colors.black },
							iCursor = { bg = custom_colors.green, fg = custom_colors.black },
							CursorLine = { bg = custom_colors.cursorline },

							Constant = { fg = custom_colors.text },
							String = { fg = custom_colors.teal2 },
							Character = { fg = custom_colors.pink3 },
							Number = { fg = custom_colors.peach },
							Boolean = { fg = custom_colors.peach },
							Float = { fg = custom_colors.peach },
							Identifier = { fg = custom_colors.blueGray1 },
							Function = { fg = custom_colors.teal1 },
							Statement = { fg = custom_colors.text },
							Conditional = { fg = custom_colors.blueGray1 },
							Repeat = { fg = custom_colors.blue3 },
							Label = { fg = custom_colors.text },
							Operator = { fg = custom_colors.blue2 },
							Keyword = { fg = custom_colors.blue2 },
							Exception = { fg = custom_colors.blue3 },
							PreProc = { fg = custom_colors.text },
							Include = { fg = custom_colors.blueGray1 },
							Define = { fg = custom_colors.yellow },
							Macro = { fg = custom_colors.yellow },
							PreCondit = { fg = custom_colors.yellow },
							Type = { fg = custom_colors.blueGray2 },
							StorageClass = { fg = colors.overlay2 },
							Structure = { fg = colors.subtext0 },
							Special = { fg = colors.overlay2 },
							SpecialChar = { fg = colors.overlay2 },
							Folded = { fg = custom_colors.blueGray2, bg = custom_colors.background3 },
							RenderMarkdownCode = { bg = custom_colors.background3 },

							TSProperty = { fg = custom_colors.blueGray1 },
							TSVariable = { fg = custom_colors.text },
							TSFunction = { fg = custom_colors.blue2 },
							TSReturn = { fg = custom_colors.blue1 },

							SnacksIndentScope = { fg = custom_colors.white },
							SnacksIndent = { fg = custom_colors.background1 },

							LspReferenceText = { bg = custom_colors.cursorline, underline = false },
							LspReferenceRead = { bg = custom_colors.cursorline, underline = false },
							LspReferenceWrite = { bg = custom_colors.cursorline, underline = false },
							LspReferenceTarget = { bg = custom_colors.cursorline, underline = false },

							["@property"] = { link = "TSProperty" },
							["@parameter"] = { fg = custom_colors.text },
							["@module"] = { fg = custom_colors.text },
							["@type"] = { link = "Type" },
							["@type.builtin"] = { link = "Type" },
							["@variable.parameter"] = { fg = custom_colors.text },
							["@variable.member"] = { link = "TSVariable" },
							["@keyword.function"] = { link = "TSFunction" },
							["@keyword.return"] = { link = "TSReturn" },
							["@function.builtin"] = { fg = custom_colors.blue2 },
							["@function"] = { link = "Function" },
							["@function.call"] = { link = "Function" },
							["@constant.builtin"] = { fg = custom_colors.peach },
							["@constant.falsy"] = { fg = custom_colors.pink3 },
						}
					end,
				},
				color_overrides = {
					mocha = {
						green = "#5DE4C7",
						subtext1 = "#cdd6f4",
						yellow = "#806F2D",
						peach = "#fab387",
						text = "#cdd6f4",
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
