require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})


local nmap = function(keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP keybindings',
  callback = function(event)
    print("LSP Attached")
    local opts = {buffer = event.buf}

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  end
})

local lspconfig = require('lspconfig')
lspconfig.tsserver.setup {}
lspconfig.gopls.setup {}

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    -- {name = 'buffer', keyword_length = 3},
    -- {name = 'luasnip', keyword_length = 2},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
  }),
  window = {
    documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
