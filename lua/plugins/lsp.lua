return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
			"catppuccin/nvim",
		},
		init = function()
			-- FIXME: workaround for https://github.com/neovim/neovim/issues/28058
			local make_client_capabilities = vim.lsp.protocol.make_client_capabilities
			function vim.lsp.protocol.make_client_capabilities()
				local caps = make_client_capabilities()
				if caps.workspace then
					caps.workspace.didChangeWatchedFiles = nil
				end
				return caps
			end

			local orig_start = vim.lsp.start
			vim.lsp.start = function(config, opts)
				opts = opts or {}
				local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
				if vim.api.nvim_buf_get_name(bufnr):match("^octo://") then
					return nil
				end
				return orig_start(config, opts)
			end
		end,
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					if vim.api.nvim_buf_get_name(event.buf):match("^octo://") then
						vim.lsp.buf_detach_client(event.buf, event.data.client_id)
						return
					end

					require("config.diagnostics").setup()

					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local fzfLua = require("fzf-lua")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("<leader>gd", fzfLua.lsp_definitions, "[G]oto [D]efinition")
					map("<leader>gi", fzfLua.lsp_implementations, "[G]oto [I]mplementation")
					-- map("<leader>gt", fzfLua.lsp_type_definitions, "[G]oto [T]ype Definition")
					map("<leader>fd", fzfLua.lsp_references, "[F]ind References")
					map("<leader>fs", "<cmd>FzfLua lsp_document_symbols symbol_width=0.9<CR>", "[F]ind [S]ymbols")
					map("<leader>fm", function()
						require("fzf-lua").lsp_document_symbols()
					end, "[F]ind [M]ethods")
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
						map("<leader>i", function()
							-- local status = vim.lsp.inlay_hint.is_enabled() and "OFF" or "ON"
							-- vim.api.nvim_notify("Toggling inlay hints " .. status, vim.log.levels.INFO, {})
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities =
				vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
			capabilities = vim.tbl_deep_extend("force", capabilities, {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			})

			local servers = {}

			servers.dcm = {}
			-- servers.golangci_lint_ls = {
			-- 	filetypes = { "go", "gomod" },
			-- 	cmd = { "golangci-lint-langserver" },
			-- 	init_options = {
			-- 		command = {
			-- 			"golangci-lint",
			-- 			"run",
			-- 			"--fast",
			-- 			"--new",
			-- 			"-c",
			-- 			"~/projects/required-workflows/.github/config/.golangci-lint-settings.yaml",
			-- 			"--out-format",
			-- 			"json",
			-- 			"--allow-parallel-runners",
			-- 			"--issues-exit-code=1",
			-- 		},
			-- 	},
			-- }
			servers.gopls = {
				settings = {
					gopls = {
						-- https://github.com/golang/tools/blob/61415bee33fa1d798499691290df4eaf9e438c03/gopls/doc/inlayHints.md
						hints = {
							parameterNames = true,
							assignVariableTypes = true,
							functionTypeParameters = true,
							rangeVariableTypes = true,
						},
					},
				},
			}
			servers.rust_analyzer = {}
			servers.ts_ls = {}
			servers.dockerls = {}
			servers.buf = {}
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
			servers.yamlls = {
				settings = {
					yaml = {
						schemas = {
							["file:///Users/camiloavelar/.config/nvim/lua/config/openapi.yaml"] = "/*",
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})

			servers.buf_ls = {}

			local _border = "rounded"

			-- Configure diagnostic float border (signs configured in init function)
			vim.diagnostic.config({
				float = { border = _border },
			})

			require("lspconfig.ui.windows").default_options.border = _border

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls" },
				automatic_enable = true,
				automatic_installation = true,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						-- Use vim.lsp.config with mason-lspconfig
						local lspconfig = require("lspconfig")
						lspconfig[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{ -- LuaLSP
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		event = "VeryLazy",
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
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
