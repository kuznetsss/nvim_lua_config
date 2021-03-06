vim.api.nvim_exec([[
" Disable auto comment symbols insert
autocmd BufEnter * setlocal formatoptions-=cro

" Terminal setup
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nobuflisted
autocmd TermOpen * setlocal bufhidden=hide

" SignatureHelp
autocmd CursorHoldI * silent! lua require('lspsaga.signaturehelp').signature_help()

" Enable colorcolumn for programming languages
let colorcolumn_enabled_for = 'lua,c,cpp,python,bash'
exe 'autocmd FileType ' . colorcolumn_enabled_for . ' set colorcolumn=' . join(range(81,83), ",")

" Change current directory to file directory
" autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Run PackerCompile on every saving plugins.lua
autocmd BufWritePost install.lua PackerCompile

" Save buffer on leave
autocmd BufLeave,FocusLost * lua require'common'.save_file()

]], false)
--[[
" Turn on wrap for quickfix
au BufReadPost quickfix setlocal wrap
--]]
