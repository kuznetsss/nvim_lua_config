require('packer').startup( function()
    use { 'wbthomason/packer.nvim', opt = true }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use { 'nvim-lua/completion-nvim',
        config = { function()
            vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
            vim.o.completeopt = "menuone,noinsert,noselect"
            vim.o.shortmess = vim.o.shortmess .. 'c'
        end }
    }
    -- Syntax hightlight
    -- use 'jackguo380/vim-lsp-cxx-highlight'
    use { 'nvim-treesitter/nvim-treesitter',
        run = function() vim.cmd('TSUpdate') end,
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

    -- Improve quickfix 
    use 'kevinhwang91/nvim-bqf'
-- colorschemes
    use { 'michalbachowski/vim-wombat256mod',
        --config = {function() vim.cmd('colorscheme wombat256mod') end}
    }
    use 'NLKNguyen/papercolor-theme'
    use 'drewtempelmeyer/palenight.vim'
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
    -- Git plugin
    use 'tpope/vim-fugitive'
    -- Indent line display
    use 'Yggdroot/indentLine'
    use 'iamcco/markdown-preview.vim'
    use 'kuznetsss/shswitch'
    use 'mhinz/vim-signify'
end
)
vim.cmd('colorscheme wombat256mod')
