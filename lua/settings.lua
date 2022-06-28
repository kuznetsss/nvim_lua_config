vim.opt.scrolloff = 5

-- Setup russian keyboard
vim.opt.keymap = 'russian-jcukenwin'
vim.opt.iminsert = 0
vim.opt.imsearch = 0

-- copy line shift from previous line
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes:1'
-- Ignore letter size (capitalize or not while search (for searching using
-- capitalize insert \C in search request
vim.opt.ignorecase = true
-- highlight search results
vim.opt.hlsearch = true
-- highlight search results while typing
vim.opt.incsearch = true

vim.opt.splitbelow = true
-- highlight current line
vim.opt.cursorline = true

vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.autowriteall = true
--vim.opt.fsync = true

vim.opt.backspace = 'indent,eol,start'

vim.opt.updatetime = 300

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath 'cache' .. '/undo_file'
vim.opt.undolevels = 5000

-- set folding by TreeSitter
vim.opt.foldmethod = 'expr'
vim.opt.foldlevelstart = 999
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Don't fold text
vim.opt.conceallevel = 0

-- show trailing whitespaces
vim.opt.list = true
vim.opt.listchars = { trail = '_', tab = '>-' }

vim.opt.grepprg = 'rg --vimgrep'
vim.g.mapleader = ' '
