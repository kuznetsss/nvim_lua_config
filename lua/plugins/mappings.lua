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
map('n','gd','<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n','gf','<cmd>lua vim.lsp.buf.definition()<CR>')
map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n','<leader>qf','<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
map('n','<leader>rn','<cmd>lua vim.lsp.buf.rename()<CR>')
map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
vim.api.nvim_set_keymap(
    'i', '<C-Space>', '<Plug>(completion_trigger)',
    {silent = true}
)
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', true)
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', true)

------ NERDTree
map('n', '<F2>', '<cmd>NERDTreeToggle<CR>')
map('i', '<F2>', '<Esc><cmd>NERDTreeToggle<CR>')

-- Startify
map('n', '<leader>s', '<cmd>Startify<CR>')

-- Fuzzy search
map('n', '<C-y>', "<cmd>FzfBuffers<CR>")
map('n', '<C-p>', "<cmd>FzfFiles<CR>")
--[[
nnoremap <F12> :TagbarToggle<CR>
nnoremap <space><space> :call FzfFindProjectFiles()<CR>
nnoremap <C-p> :execute "FzfFiles " . expand("%:p:h")<CR>
nnoremap <C-y> :FzfBuffers<CR>
]]--
