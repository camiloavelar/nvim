local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


return require('lazy').setup({
  {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  dependencies = { {'nvim-lua/plenary.nvim'} }
  },

  {
	  'rose-pine/neovim',
	  name = 'rose-pine',
  },

  {
      "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
          }
      end
  },

  {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
  },
  "nvim-treesitter/playground",
  "theprimeagen/harpoon",
  "theprimeagen/refactoring.nvim",
  "mbbill/undotree",
  "tpope/vim-fugitive",
  "nvim-treesitter/nvim-treesitter-context",

  {
	  'neovim/nvim-lspconfig',
	  dependencies = {
		  -- LSP Support
		  {'williamboman/nvim-lsp-installer'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  },

  "folke/zen-mode.nvim",
  "laytan/cloak.nvim",
})

