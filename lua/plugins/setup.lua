require('packer').startup( function()
    use { 'wbthomason/packer.nvim', opt = true }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use { 'nvim-lua/completion-nvim',
        config = function()
            vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
            vim.o.completeopt = "menuone,noinsert,noselect"
            vim.o.shortmess = vim.o.shortmess .. 'c'
            vim.g.completion_auto_change_source = 1
            vim.g.completion_chain_complete_list = {
              default = {
                default = {
                  { complete_items = {'lsp'} },
                  { complete_items = { 'path', 'buffer' } },
                  { complete_items = { 'buffers' } },
                }
              }
            }
        end,
        requires = { 'steelsojka/completion-buffers' }
    }
    -- Syntax hightlight
    use { 'nvim-treesitter/nvim-treesitter',
        disabled = true,
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
    -- Close buffer
    use 'ojroques/nvim-bufdel'

-- colorschemes
    use 'michalbachowski/vim-wombat256mod' 
    use 'NLKNguyen/papercolor-theme'
    use 'drewtempelmeyer/palenight.vim'
    use 'ayu-theme/ayu-vim'
    use { 'tjdevries/gruvbuddy.nvim',
    	requires = { 'tjdevries/colorbuddy.nvim' }
    }
    use { 'Th3Whit3Wolf/onebuddy',
    	requires = { 'tjdevries/colorbuddy.nvim' }
    }

-- Draw colors of codes
    use { 'norcalli/nvim-colorizer.lua',
        config = function()
            require'colorizer'.setup()
        end
    }

-- Indent draw
    --use 'Yggdroot/indentLine'
    use { 'glepnir/indent-guides.nvim',
        config = function() 
            require('indent_guides').setup({
                exclude_filetypes = {
                    'help', 'dashboard', 'dashpreview',
                    'NvimTree','vista','sagahover'
                };
                even_colors = { fg ='#2E323A',bg='#34383F' };
                odd_colors = {fg='#34383F',bg='#2E323A'};
            })
        end
    }
-- Fuzzy finder
   use { 'junegunn/fzf.vim',
        config = { function()
            vim.g.fzf_command_prefix = 'Fzf'
        end }
    }

-- -----------------Haven't refactored yet
    use { 'vim-airline/vim-airline',
        requires = { 'vim-airline/vim-airline-themes' },
        config = { function()
            vim.g.airline_theme = 'powerlineish'
            vim.cmd 'let g:airline#extensions#tabline#enabled = 1'
            vim.cmd 'let g:airline#extensions#keymap#enabled = 0'
            vim.cmd 'let g:airline#extensions#whitespace#enabled = 0'
            vim.cmd 'let g:airline_detect_spell = 0'
            vim.cmd 'let g:airline#extensions#nvimlsp#enabled = 1'
        end }
    }
    
    use { 'scrooloose/nerdtree',
        config = { function()
            vim.g.NERDTreeShowHidden = 1
        end }
    }
    use 'preservim/nerdcommenter'
    use 'mhinz/vim-startify'
    -- Git plugin
    use 'tpope/vim-fugitive'
    -- Indent line display
    use 'iamcco/markdown-preview.vim'

    use 'mhinz/vim-signify'
end
)
vim.cmd('colorscheme wombat256mod')
