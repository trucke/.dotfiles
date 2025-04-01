vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

vim.g.have_nerd_font = true
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.local/share/nvim'
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.inccommand = 'split'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 10
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.isfname:append('@-@')

vim.opt.colorcolumn = '110'
-- vim.o.termguicolors = true

vim.opt.laststatus = 3

vim.opt.cursorline = true
-- vim.opt.confirm = true
