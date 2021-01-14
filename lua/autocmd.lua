vim.api.nvim_exec([[
" Disable auto comment symbols insert
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Change current directory to file directory
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Terminal setup
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nobuflisted
autocmd TermOpen * setlocal bufhidden=hide
]], false)
--[[
" Turn on wrap for quickfix
au BufReadPost quickfix setlocal wrap
--]]

