vim.api.nvim_exec([[
" Disable auto comment symbols insert
autocmd BufEnter * setlocal formatoptions-=cro


" Terminal setup
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nobuflisted
autocmd TermOpen * setlocal bufhidden=hide

" Enable colorcolumn for programming languages
let colorcolumn_enabled_for = 'lua,h,hh,c,cc,cpp,py,sh'
exe 'autocmd FileType ' . colorcolumn_enabled_for . ' set colorcolumn=' . join(range(81,200), ",")

" Change current directory to file directory
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Run PackerCompile on every saving plugins.lua
autocmd BufWritePost install.lua PackerCompile

]], false)
--[[
" Turn on wrap for quickfix
au BufReadPost quickfix setlocal wrap
--]]
