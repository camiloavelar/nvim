local mapkey = require("util.keymapper").mapkey

mapkey("<leader>zz", "ZenMode", "n")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, noremap = true })

-- Buffer Navigation
mapkey("<leader>bn", "bnext", "n") -- Next buffer
mapkey("<leader>bp", "bprevious", "n") -- Prev buffer

-- Noice
mapkey("<leader>fn", "Noice telescope", "n")
mapkey("<leader>q", "Noice dismiss", "n")

-- Directory Navigatio}n
mapkey("<leader>pv", ":Ex", "n")
mapkey("<leader>e", "NvimTreeToggle", "n")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Source File" })

-- Pane and Window Navigation
mapkey("<C-h>", "<C-w>h", "n") -- Navigate Left
mapkey("<C-j>", "<C-w>j", "n") -- Navigate Down
mapkey("<C-k>", "<C-w>k", "n") -- Navigate Up
mapkey("<C-l>", "<C-w>l", "n") -- Navigate Right
mapkey("<C-h>", "wincmd h", "t") -- Navigate Left
mapkey("<C-j>", "wincmd j", "t") -- Navigate Down
mapkey("<C-k>", "wincmd k", "t") -- Navigate Up
mapkey("<C-l>", "wincmd l", "t") -- Navigate Right

-- Window Management
mapkey("<leader>sv", "vsplit", "n") -- Split Vertically
mapkey("<leader>sh", "split", "n") -- Split Horizontally
mapkey("<C-Up>", "resize +2", "n")
mapkey("<C-Down>", "resize -2", "n")
mapkey("<C-Left>", "vertical resize +2", "n")
mapkey("<C-Right>", "vertical resize -2", "n")

-- Indenting
vim.keymap.set("v", "<", "<gv", { silent = true, noremap = true })
vim.keymap.set("v", ">", ">gv", { silent = true, noremap = true })

-- Show Full File-Path
mapkey("<leader>pa", "echo expand('%:p')", "n") -- Show Full File Path

local api = vim.api

-- Comments
api.nvim_set_keymap("n", "<C-_>", "<leader>ctl", { noremap = false })
api.nvim_set_keymap("v", "<C-_>", "col", { noremap = false })

