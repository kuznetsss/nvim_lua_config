--[[
nnoremap <leader>r :source ~/.vim/vimrc<CR>
--]]
local nmap = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, { noremap = false, silent = true })
end
local imap = function(lhs, rhs)
    vim.keymap.set('i', lhs, rhs, { noremap = false, silent = true })
end

nmap('<C-k>', ':bnext<CR>')
nmap('<C-j>', ':bprev<CR>')

nmap('<A-t>', ':split | resize 20 | terminal<CR>')
nmap(
    '<C-t>',
    '<Esc>:exe \'split | resize 20 | terminal bash -c "cd \' . expand("%:p:h") . \' && bash"\'<CR>'
)

nmap('<C-h>', '<C-o>')
nmap('<C-l>', '<C-i>')

imap('<C-l>', '<C-^>')
imap('<A-t>', '<Esc>:split | resize 20 | terminal<CR>')
imap(
    '<C-t>',
    '<Esc>:exe \'split | resize 20 | terminal bash -c "cd \' . expand("%:p:h") . \' && bash"\'<CR>'
)
vim.api.nvim_set_keymap(
    't',
    '<Esc>',
    '"<C-\\><C-n>"',
    { noremap = true, expr = true, silent = true }
)

vim.cmd "command LspLog :lua vim.cmd('e'..vim.lsp.get_log_path())"

-- nnoremap('<Esc><Esc>', ':noh<CR>')
