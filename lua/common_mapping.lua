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
nnoremap('<C-x>', ':bp<bar>sp<bar>bn<bar>bd<CR>')

nnoremap('<C-t>', ':split | resize 20 | terminal<CR>')

nnoremap('<C-h>', '<C-o>')
nnoremap('<C-l>', '<C-i>')

inoremap('<C-l>', '<C-^>')
inoremap('<C-t>', '<Esc>:split | resize 20 | terminal<CR>')
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap=true, silent=true})
