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

local openTerminal = function(directory)
    directory = directory or vim.loop.cwd()
    local buffer = vim.api.nvim_create_buf(false, false)
    vim.cmd.vsplit()
    vim.cmd.wincmd('J')
    local window = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_height(window, 20)
    vim.api.nvim_win_set_buf(window, buffer)
    vim.fn.termopen('zsh', {cwd = directory})
end

nmap('<A-t>', function()
    local pathStr = vim.api.nvim_buf_get_name(0)
    local path = require'plenary.path':new(pathStr)
    if not path:is_path() then
        vim.notify("Current buffer is not a file", vim.log.levels.WARN)
        return
    end
    openTerminal(path:parent():expand())
end
)
nmap('<C-t>', openTerminal)

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
