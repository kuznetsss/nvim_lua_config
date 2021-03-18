--[[
nnoremap <leader>r :source ~/.vim/vimrc<CR>
--]]
local nnoremap = function(lhs, rhs)
    vim.api.nvim_set_keymap('n', lhs, rhs, {noremap=true, silent=true})
end
local inoremap = function(lhs, rhs)
    vim.api.nvim_set_keymap('i', lhs, rhs, {noremap=true, silent=true})
end

nnoremap('<C-k>', ':bnext<CR>')
nnoremap('<C-j>', ':bprev<CR>')

nnoremap('<A-t>', ':split | resize 20 | terminal<CR>')
nnoremap('<C-t>', '<Esc>:exe \'split | resize 20 | terminal bash -c "cd \' . expand("%:p:h") . \' && bash"\'<CR>')

nnoremap('<C-h>', '<C-o>')
nnoremap('<C-l>', '<C-i>')

inoremap('<C-l>', '<C-^>')
inoremap('<A-t>', '<Esc>:split | resize 20 | terminal<CR>')
inoremap('<C-t>', '<Esc>:exe \'split | resize 20 | terminal bash -c "cd \' . expand("%:p:h") . \' && bash"\'<CR>')
vim.api.nvim_set_keymap('t', '<Esc>', '(&filetype == "fzf") ? "<Esc>" : "<C-\\><C-n>"', {noremap=true, expr=true, silent=true})

vim.cmd("command LspLog :lua vim.cmd('e'..vim.lsp.get_log_path())")
