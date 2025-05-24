return {
	{
		"saghen/blink.cmp",
		dependencies = { "fang2hou/blink-copilot" },
		event = "VeryLazy",
		version = "1.*",
		opts = {
			keymap = {
				preset = "default",

				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			completion = {
				documentation = {
					auto_show = true,
					window = {
						border = "rounded",
					},
				},
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "kind", gap = 1 },
							{ "source_name" },
						},
						components = {
							source_name = {
								text = function(ctx)
									return "[" .. ctx.source_name .. "]"
								end,
							},
						},
					},
				},
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					lsp = {
						score_offset = 100,
					},
					copilot = {
						name = "Copilot",
						module = "blink-copilot",
						score_offset = 50,
						async = true,
					},
				},
			},
		},
	},
}
