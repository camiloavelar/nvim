local mapkey = require("util.keymapper").mapkey

local config = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
      file_ignore_patterns = {
        ".git/",
        "node_modules",
        "coverage",
        "dist",
        "build",
        "target",
        "vendor",
        "yarn.lock",
        "package-lock.json",
      },
    },
		pickers = {
			git_files = {
				previewer = true,
        hidden = true,
			},
			find_files = {
				previewer = true,
        hidden = true,
        no_ignore = true,
			},
			live_grep = {
				previewer = true,
        hidden = true
			},
			buffers = {
				-- theme = "dropdown",
				previewer = true,
			},
		},
	})
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.3",
	lazy = false,
	dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
	config = config,
	keys = {
		mapkey("<leader>fk", "Telescope keymaps", "n"),
		mapkey("<leader>ff", "Telescope harpoon marks", "n"),
		mapkey("<leader>fh", "Telescope help_tags", "n"),
		mapkey("<leader>pf", "Telescope find_files", "n"),
		mapkey("<C-p>", "Telescope git_files", "n"),
    mapkey("<leader>fd", "Telescope diagnostics", "n"),
		mapkey("<leader>fgl", "Telescope live_grep", "n"),
		mapkey("<leader>fgs", "Telescope grep_string", "n"),
		mapkey("<leader>fb", "Telescope buffers", "n"),
		mapkey("<leader>bl", "Telescope buffers", "n"),
		mapkey("<leader>fs", "Telescope lsp_document_symbols", "n"),
		mapkey("<leader>gc", "Telescope git_commits", "n"),
		mapkey("<leader>gb", "Telescope git_branches", "n"),
		mapkey("<leader>ts", "Telescope treesitter", "n"),
    mapkey("<leader>fd", "Telescope lsp_references", "n"),
    mapkey("<leader>gD", "Telescope lsp_definitions", "n"),
    mapkey("<leader>gi", "Telescope lsp_implementations", "n"),
    mapkey("<leader>gt", "Telescope lsp_type_definitions", "n"),
	},
  config = function ()
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>fw", function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end, { desc = "Search for word under cursor" })

    vim.keymap.set("n", "<leader>fW", function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end, { desc = "Search for full word under cursor" })
  end
}
