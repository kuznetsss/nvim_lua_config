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

vim.api.nvim_set_keymap(
    't',
    '<Esc>',
    '"<C-\\><C-n>"',
    { noremap = true, expr = true, silent = true }
)

vim.cmd "command LspLog :lua vim.cmd('e'..vim.lsp.get_log_path())"

-- Plugins

local map = require('common').map
------ LSP
map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gf', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gs', '<cmd>ClangdSwitchSourceHeader<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gr', '<cmd>Telescope lsp_references<CR>')
map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n', '<leader>qf', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>=', '<cmd>lua vim.lsp.buf.format({async=true})<CR>')
map('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
map('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
map('n', '<leader>cf', '<cmd>lua vim.lsp.buf.format({async=true})<CR>')

-- DAP and debug
map('n', '<F10>', "<cmd>lua require'dap'.continue()<CR>")
map('n', '<F11>', "<cmd>lua require'dap'.step_over()<CR>")
map('n', '<F12>', "<cmd>lua require'dap'.step_into()<CR>")
map('n', '<leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<CR>")

-- Gitsigns
map('n', ']c', '<cmd>Gitsigns next_hunk<CR>')
map('n', '[c', '<cmd>Gitsigns prev_hunk<CR>')
map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>')
map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>')
map('n', '<leader>ga', '<cmd>Gitsigns stage_hunk<CR>')

-- Trouble
-- map('n', '<F1>', '<cmd>TroubleToggle<CR>')

------ nvim-tree
map(
    'n',
    '<F2>',
    "<cmd>NvimTreeFindFileToggle<CR>"
)
map(
    'i',
    '<F2>',
    "<Esc><cmd>NvimTreeFindFileToggle<CR>"
)

-- Telescope
map(
    'n',
    '<C-y>',
    "<cmd>lua require'telescope.builtin'.buffers{ show_all_buffers = true }<CR>"
)
map('n', '<leader>tc', "<cmd> lua require'telescope.builtin'.commands{}<CR>")
map(
    'n',
    '<leader>th',
    "<cmd> lua require'telescope.builtin'.command_history{}<CR>"
)
map('n', '<leader>tr', "<cmd> lua require'telescope.builtin'.registers{}<CR>")
map('n', '<leader>to', "<cmd> lua require'telescope.builtin'.vim_options{}<CR>")
map('n', '<leader>tm', "<cmd> lua require'telescope.builtin'.help_tags{}<CR>")
map('n', '<leader>ti', "<cmd> lua require'telescope.builtin'.highlights{}<CR>")
map('n', '<leader>tg', "<cmd> lua require'telescope.builtin'.live_grep{}<CR>")
map('n', '<leader>tw', "<cmd> lua require'telescope.builtin'.grep_string{}<CR>")
map('n', '<leader>ts', '<cmd>Telescope spell_suggest <CR>')
map('n', '<leader>tq', '<cmd>Telescope quickfix <CR>')
map('n', '<C-p>', "<cmd> lua require'telescope.builtin'.find_files()<CR>")

-- Telescope git
map('n', '<leader>gb', '<cmd>Telescope git_branches<CR>')

-- zk mappings
--see filetype/markdown.md for more mappings
map('n', '<leader>zk', '<cmd>cd ~/Documents/zk | e main.md<CR>')
map('n', '<leader>zc', '<cmd>cd ~/Documents/neetcode-zk | e main.md<CR>')

-- Packer mapping
map('n', '<leader>ps', '<cmd>PackerSync<CR>')

-- ChatGPT
map('n', '<leader>cg', '<cmd>ChatGPT<CR>')
