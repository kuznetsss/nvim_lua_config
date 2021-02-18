local function map(mode, mapping, command, expr, noremap)
    local options = {
        expr = expr or false,
        noremap = noremap or true,
        silent = true
    }
    vim.api.nvim_set_keymap(mode, mapping, command, options)
end
------ BufDel
map('n', '<C-x>', '<cmd>BufDel<CR>')

------ LSP
map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gf', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gs', '<cmd>ClangdSwitchSourceHeader<CR>')
map('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
map('n', 'gr', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>")
map('n', 'gh', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>")
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '[e', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>")
map('n', ']e', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>")
map('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n', '<leader>qf', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>")
map('n', '<leader>ee', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>")
map('n', '<leader>rn', "<cmd>lua require('lspsaga.rename').rename()<CR>")
map('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
map('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')

------ Completion
-- vim.api.nvim_set_keymap(
--     'i', '<C-Space>', '<Plug>(completion_trigger)',
--     {silent = true}
-- )
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', true)
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', true)
map('i', '<C-Space>', 'compe#complete()', true)
map('i', '<CR>', "compe#confirm('<CR>')", true)
map('i', '<C-e>', "compe#close('<C-e>')", true)

------ NERDTree
map('n', '<F2>', '<cmd>NERDTreeToggle<CR>')
map('i', '<F2>', '<Esc><cmd>NERDTreeToggle<CR>')

-- Startify
map('n', '<leader>s', '<cmd>Startify<CR>')

-- Fuzzy search
map('n', '<C-y>', "<cmd>FzfBuffers<CR>")
map('n', '<C-p>', "<cmd>FzfFiles<CR>")
map('n', '<A-p>', "<cmd>FzfRg<CR>")
--[[
nnoremap <F12> :TagbarToggle<CR>
nnoremap <space><space> :call FzfFindProjectFiles()<CR>
nnoremap <C-p> :execute "FzfFiles " . expand("%:p:h")<CR>
nnoremap <C-y> :FzfBuffers<CR>
]]--
