-- herdr half of Ctrl+h/j/k/l is already bound in ~/.config/herdr/config.toml.
-- It decides "is this pane Neovim?" by a marker file this plugin writes on
-- entry, so it has to load at startup: lazy-loading on the keys themselves
-- would never get the first press, which herdr would consume as a pane move.
return {
	{
		"aimdevlee/herdr-nvim-nav",
		lazy = false,
		priority = 100,
		config = function()
			require("herdr-nvim-nav").setup({ with_tmux = false })
		end,
	},
}
