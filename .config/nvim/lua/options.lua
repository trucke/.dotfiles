-- highlight matches with last search pattern
vim.opt.hlsearch = false
-- highlight match while typing search pattern
vim.opt.incsearch = true
-- print the line number in front of each line
vim.opt.number = true
-- Don't show the mode, since it's already in status line
vim.opt.showmode = false
-- show relative line number in front of each line
vim.opt.relativenumber = true
-- minimum nr. of lines above and below cursor
vim.opt.scrolloff = 8
-- number of spaces that <Tab> in file uses
vim.opt.tabstop = 4
-- number of spaces that <Tab> uses while editing
vim.opt.softtabstop = 4
-- number of spaces to use for (auto)indent step
vim.opt.shiftwidth = 4
-- use spaces when <Tab> is inserted
vim.opt.expandtab = true
-- long lines wrap and continue on the next line
vim.opt.wrap = false
-- use the clipboard as the unnamed register
vim.opt.clipboard = 'unnamedplus'
-- keep signcolumn on by default
vim.opt.signcolumn = 'yes'
-- after this many milliseconds flush swap file
vim.opt.updatetime = 250
-- time in milliseconds to wait for a mapped sequence to complete
vim.opt.timeoutlen = 500
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'
-- save undo information in a file
vim.opt.undofile = true
-- keep backup file after overwriting a file
vim.opt.backup = false
-- whether to use a swapfile for a buffer
vim.opt.swapfile = false
-- screen columns that are highlighted - Useful to align text
vim.opt.colorcolumn = '80'

-- characters included in file names and pathnames
-- vim.opt.isfname:append('@-@')
-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
