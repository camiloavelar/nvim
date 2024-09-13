return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local diagnostic_signs = { Error = " ", Warn = " ", Hint = "󱧤", Info = "" }

			for type, icon in pairs(diagnostic_signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local telescope = require("telescope.builtin")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("<leader>gd", telescope.lsp_definitions, "[G]oto [D]efinition")
					map("<leader>gi", telescope.lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>gt", telescope.lsp_type_definitions, "[G]oto [T]ype Definition")
					map("<leader>fd", telescope.lsp_references, "[F]ind References")
					map("<leader>fs", "<cmd>Telescope lsp_document_symbols symbol_width=0.9<CR>", "[F]ind [S]ymbols")
					map(
						"<leader>fm",
						"<cmd>Telescope lsp_document_symbols symbol_width=0.9 symbols=['method','function']<CR>",
						"[F]ind [M]methods"
					)
					map("K", function()
						local winid = require("ufo").peekFoldedLinesUnderCursor()
						if not winid then
							vim.lsp.buf.hover()
						end
					end, "Hover Documentation")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					-- The following autocommand is used to enable inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local servers = {}

			servers.gopls = {}
			servers.rust_analyzer = {}
			servers.ts_ls = {}
			servers.dockerls = {}
			servers.buf = {} -- TODO: check this out later, the language server is not yet available in this package
			servers.bufls = {} -- TODO: this is not maintained anymore
			servers.pylsp = {
				filetypes = { "py", "tiltfile" },
			}
			servers.bashls = {
				filetypes = { "sh", "aliasrc" },
			}
			servers.jsonls = {
				filetypes = { "json", "jsonc" },
			}
			servers.lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})

			local _border = "rounded"

			vim.diagnostic.config({
				float = { border = _border },
			})

			require("lspconfig.ui.windows").default_options.border = _border

			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border }),
			}

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				automatic_installation = true,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						server.handlers = vim.tbl_deep_extend("force", {}, handlers, server.handlers or {})
						-- FIXME: workaround for https://github.com/neovim/neovim/issues/28058
						for _, v in pairs(server) do
							if type(v) == "table" and v.workspace then
								v.workspace.didChangeWatchedFiles = {
									dynamicRegistration = false,
									relativePatternSupport = false,
								}
							end
						end
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>ff",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform can also run multiple formatters sequentially
					-- python = { "isort", "black" },
					--
					-- You can use a sub-list to tell conform to run *until* a formatter
					-- is found.
					-- javascript = { { "prettierd", "prettier" } },
				},
				format_on_save = function()
					if not vim.g.enable_autoformat then
						return
					end
					return { timeout_ms = 500, lsp_fallback = true }
				end,
			})
			vim.api.nvim_create_user_command("FormatDisable", function()
				vim.g.enable_autoformat = false
			end, {
				desc = "Disable autoformat-on-save",
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.g.enable_autoformat = true
			end, {
				desc = "Re-enable autoformat-on-save",
			})
		end,
	},
}
