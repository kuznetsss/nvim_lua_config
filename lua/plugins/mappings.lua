local map = require('common').map
------ BufDel
map('n', '<C-x>', '<cmd>BufDel<CR>')

------ LSP
map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gf', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gs', '<cmd>ClangdSwitchSourceHeader<CR>')
map('n', 'K', "<cmd>Lspsaga hover_doc<CR>")
map('n', 'gr', "<cmd>Lspsaga lsp_finder<CR>")
map('n', 'gh', "<cmd>Lspsaga preview_definition<CR>")
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '[e', "<cmd>Lspsaga diagnostic_jump_prev<CR>")
map('n', ']e', "<cmd>Lspsaga diagnostic_jump_next<CR>")
map('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n', '<leader>qf', "<cmd>Lspsaga code_action<CR>")
map('n', '<leader>ee', "<cmd>Lspsaga show_line_diagnostics<CR>")
map('n', '<leader>rn', "<cmd>Lspsaga rename<CR>")
map('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
map('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
map('n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>')

-- Gitsigns
map('n', ']c', '<cmd>Gitsigns next_hunk<CR>')
map('n', '[c', '<cmd>Gitsigns prev_hunk<CR>')
map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>')
map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>')
map('n', '<leader>ga', '<cmd>Gitsigns stage_hunk<CR>')

-- Trouble
map('n', '<F1>', '<cmd>TroubleToggle<CR>')

------ nvim-tree
map(
    'n',
    '<F2>',
    "<cmd>lua require'plugins.commands'.nvim_tree_find_toggle()<CR>"
)
map(
    'i',
    '<F2>',
    "<Esc><cmd>lua require'plugins.commands'.nvim_tree_find_toggle()<CR>"
)

-- Fuzzy search
map('n', '<C-y>', "<cmd>lua require'telescope.builtin'.buffers{ show_all_buffers = true }<CR>")
map('n', '<leader>tc', "<cmd> lua require'telescope.builtin'.commands{}<CR>")
map('n', '<leader>th', "<cmd> lua require'telescope.builtin'.command_history{}<CR>")
map('n', '<leader>tr', "<cmd> lua require'telescope.builtin'.registers{}<CR>")
map('n', '<leader>to', "<cmd> lua require'telescope.builtin'.vim_options{}<CR>")
map('n', '<leader>tm', "<cmd> lua require'telescope.builtin'.help_tags{}<CR>")
map('n', '<leader>ti', "<cmd> lua require'telescope.builtin'.highlights{}<CR>")
map('n', '<leader>tg', "<cmd> lua require'telescope.builtin'.grep_string{}<CR>")
map('n', '<C-p>', "<cmd> lua require'telescope.builtin'.find_files()<CR>")

-- zk mappings
--see filetype/markdown.md for more mappings
map('n', '<leader>zk', '<cmd>cd ~/Documents/zk | e main.md<CR>')

-- Packer mapping
map('n', '<leader>ps', '<cmd>PackerSync<CR>')


