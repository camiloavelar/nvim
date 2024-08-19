local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = "150"
opt.signcolumn = "yes"
opt.cmdheight = 0
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect"
opt.guicursor =
	"n-v-c:block,i-ci-ve:ver20,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.cmd("highlight TreesitterContext guifg=#ffffff guibg=#131313")
vim.cmd("highlight TreesitterContextLineNumber guifg=#aaaaaa guibg=NONE")
vim.cmd("set cursorline")
vim.cmd("highlight CursorLineNr guifg=NONE guibg=NONE")
vim.cmd("highlight CursorLine guibg=#111111")

-- Behaviour
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.iskeyword:append("-")
opt.mouse:append("a")
opt.clipboard:append("unnamedplus")
opt.modifiable = true
opt.encoding = "UTF-8"
opt.showmode = false
opt.fixendofline = false
