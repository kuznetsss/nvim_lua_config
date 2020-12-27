require 'plugins/packer_bootstrap'
vim.cmd 'packadd packer.nvim'

require('packer').startup( function()
    use { 'wbthomason/packer.nvim', opt = true }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use { 'nvim-lua/completion-nvim',
        config = { function()
            vim.g.completion_matching_strategy_list = {'substring', 'fuzzy'}
        end }
    }
    -- Syntax hightlight
    -- use 'jackguo380/vim-lsp-cxx-highlight'
    use { 'nvim-treesitter/nvim-treesitter',
        run = function() vim.cmd 'TSUpdate' end,
        config = { function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = "maintained",
                highlight = { enable = true }
            }
        end }
    }
    -- Vim wiki
    use { 'vimwiki/vimwiki',
        config = { function()
            vim.g.vimwiki_list = {
                {path = '~/Documents/vimwiki/', syntax = 'markdown', ext = '.md'}
            }
        end },
        enable = true
    }
-- TODO use this plugin
--        use {'lervag/wiki.vim',
--           config = {function()
--              vim.g.wiki_root = '~/Documents/vimwiki/'
--             vim.g.wiki_extension = '.md'
--        end }
--   }

-- colorschemes
    use { 'michalbachowski/vim-wombat256mod',
        config = {function() vim.cmd('colorscheme wombat256mod') end}
    }
    use 'NLKNguyen/papercolor-theme'
    use { 'drewtempelmeyer/palenight.vim',
        --config = {function() vim.cmd('colorscheme palenight') end}
    }
    use 'ayu-theme/ayu-vim'


-- -----------------Haven't refactored yet
    use { 'vim-airline/vim-airline',
        requires = { 'vim-airline/vim-airline-themes' },
        config = { function()
            vim.g.airline_theme = 'powerlineish'
            vim.cmd 'let g:airline#extensions#tabline#enabled = 1'
            vim.cmd 'let g:airline#extensions#keymap#enabled = 0'
            vim.cmd 'let g:airline#extensions#whitespace#enabled = 0'
            vim.cmd 'let g:airline_detect_spell = 0'
        end }
    }
    use { 'scrooloose/nerdtree',
        config = { function()
            vim.g.NERDTreeShowHidden = 1
        end }
    }
    use 'preservim/nerdcommenter'
    use 'mhinz/vim-startify'
    use { 'junegunn/fzf.vim',
        config = { function()
            vim.g.fzf_command_prefix = 'Fzf'
        end }
    }
    -- Remove quickfix from buffers
    use 'romainl/vim-qf'
    -- Git plugin
    use 'tpope/vim-fugitive'
    -- Indent line display
    use 'Yggdroot/indentLine'
    use 'iamcco/markdown-preview.vim'
    use 'kuznetsss/shswitch'
    use 'honza/vim-snippets'
    use 'mhinz/vim-signify'
end
)

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
    map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
    map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
    map('n','<leader>rn','<cmd>lua vim.lsp.buf.rename()<CR>')
    map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
    vim.fn.nvim_buf_set_keymap(0, 'i', '<C-Space>', '<Plug>(completion_trigger)', {noremap = false, silent = true});
    vim.fn.nvim_buf_set_keymap(0, 'i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {noremap = true, silent = true, expr = true});
    vim.fn.nvim_buf_set_keymap(0, 'i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {noremap = true, silent = true, expr = true});

    --map('i', '<S-Tab>', 'pumvisible() ? <C-p> : <S-Tab>')
end

vim.fn.nvim_set_keymap('n', '<F1>', ":exe 'h ' . expand('<cword>')<CR>", {noremap = true, silent = true})

local lspconfig = require('lspconfig')

lspconfig.sumneko_lua.setup{
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
    filetypes = { 'h', 'c', 'cpp', 'objc', 'objcpp' },
    -- on_init = function to handle changing offsetEncoding
    -- root_dir = root_pattern('compile_commands.json', 'compile_flags.txt', '.git') or dirname
    on_attach = custom_attach
}
vim.o.completeopt = "menuone,noinsert,noselect"
vim.g.lsp_cxx_hl_log_file = '/home/sergey/vim_log.txt'
vim.g.lsp_cxx_hl_verbose_log = 1
vim.g.lsp_cxx_hl_ft_whitelist = {'c', 'cpp', 'objc', 'objcpp', 'cc', 'h'}
