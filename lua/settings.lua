local set_option = require'common'.set_option

set_option('wo', 'scrolloff', 5)

-- Setup russian keyboard
set_option('bo', 'keymap', 'russian-jcukenwin')
set_option('bo', 'iminsert', 0)
set_option('bo', 'imsearch', 0)

-- copy line shift from previous line
set_option('bo', 'autoindent', true)
set_option('bo', 'smartindent', true)

set_option('wo', 'number', true)
set_option('wo', 'relativenumber', true)
set_option('wo', 'signcolumn', 'yes:2')
-- Ignore letter size (capitalize or not) while search (for searching using
-- capitalize insert \C in search request)
set_option('o', 'ignorecase', true)
-- highlight search results
set_option('o', 'hlsearch', true)
-- highlight search results while typing
set_option('o', 'incsearch', true)

set_option('o', 'splitbelow', true)
-- highlight current line
set_option('wo', 'cursorline', true)

set_option('bo', 'autoread', true)
set_option('o', 'autowrite', true)
vim.opt.autowriteall = true
--set_option('o', 'fsync', true)

set_option('o', 'backspace', 'indent,eol,start')

set_option('o', 'updatetime', 300)

set_option('bo', 'shiftwidth', 4)
set_option('bo', 'tabstop', 4)
set_option('bo', 'expandtab', true)
set_option('bo', 'expandtab', true)
set_option('o', 'smarttab', true)

set_option('bo', 'undofile', true)
set_option('o', 'undodir', vim.fn.stdpath('cache')..'/undo_file')
set_option('bo', 'undolevels', 5000)

-- set folding by syntax
set_option('wo', 'foldmethod', 'syntax')
set_option('o', 'foldlevelstart', 999)

-- Don't fold text
set_option('wo', 'conceallevel', 0)

-- show trailing whitespaces
vim.opt.list = true
vim.opt.listchars = { trail = ' ', tab = '  ' }

