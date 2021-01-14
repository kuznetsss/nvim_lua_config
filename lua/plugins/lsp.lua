vim.o.completeopt = "menuone,noinsert,noselect"

local map = function(type, key, value)
    vim.fn.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

local custom_attach = function()
    require('completion').on_attach()

    map('n','gd','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','gf','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
    map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
    map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
    map('n','<leader>rn','<cmd>lua vim.lsp.buf.rename()<CR>')
    map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
    vim.fn.nvim_buf_set_keymap(0, 'i', '<C-Space>', '<Plug>(completion_trigger)', {noremap = false, silent = true});
    vim.fn.nvim_buf_set_keymap(0, 'i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {noremap = true, silent = true, expr = true});
    vim.fn.nvim_buf_set_keymap(0, 'i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {noremap = true, silent = true, expr = true});
end

vim.fn.nvim_set_keymap('n', '<F1>', ":exe 'h ' . expand('<cword>')<CR>", {noremap = true, silent = true})

local lspconfig = require('lspconfig')

lspconfig.sumneko_lua.setup{
    cmd = {'/usr/bin/lua-language-server', '-E', '/usr/share/lua-language-server/main.lua'},
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
            completion = { keywordSnippet = "Disable", },
            diagnostics = { enable = true, globals = { "vim", "describe", "it", "before_each", "after_each" } },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    [vim.fn.stdpath("config")..'/lua'] = true,
                }
            }
        }
    },
    on_attach = custom_attach
}
lspconfig.clangd.setup {
    cmd = { "clangd", "--background-index", "-j=6", "--header-insertion=never"},
    log_level =  vim.lsp.protocol.MessageType.Log,
    highlight = {
        enable = true,
        lsRanges = true
    },
    filetypes = { 'h', 'hh', 'c', 'cc', 'cpp', 'objc', 'objcpp' },
    -- on_init = function to handle changing offsetEncoding
    -- root_dir = root_pattern('compile_commands.json', 'compile_flags.txt', '.git') or dirname
    on_attach = custom_attach
}
v
