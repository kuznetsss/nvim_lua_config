local use = require('packer').use
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
    use { 'glepnir/lspsaga.nvim',
        config = function()
            require 'lspsaga'.init_lsp_saga {
                use_saga_diagnostic_sign = true,
                error_sign = '',
                warn_sign = '',
                hint_sign = '',
                infor_sign = '',
                error_header = "  Error",
                warn_header = "  Warn",
                hint_header = "  Hint",
                infor_header = "  Infor",
                -- max_diag_msg_width = 50,
                code_action_icon = ' ',
                code_action_keys = { quit = 'q',exec = '<CR>' },
                finder_definition_icon = '  ',
                finder_reference_icon = '  ',
                max_finder_preview_lines = 10,
                finder_action_keys = {
                    open = '<CR>', vsplit = 's', split = 'i',
                    quit = 'q', scroll_down = '<C-f>', scroll_up = '<C-b>'
                },
                definition_preview_icon = '  ',
                -- 1: thin border | 2: rounded border | 3: thick border
                border_style = 1
                -- rename_prompt_prefix = '➤',
                -- if you don't use nvim-lspconfig you must pass your server name and
                -- the related filetypes into this table
                -- like server_filetype_map = {metals = {'sbt', 'scala'}}
                -- server_filetype_map = {}
            }
        end
    }
    -- Syntax hightlight
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
-- Icons
    use 'kyazdani42/nvim-web-devicons'

-- Indent draw
    --use 'Yggdroot/indentLine'
    use { 'glepnir/indent-guides.nvim',
        config = function()
            require('indent_guides').setup({
                exclude_filetypes = {
                    'help', 'dashboard', 'dashpreview',
                    'NvimTree','vista','sagahover', 'lspsaga'
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
    use 'ryanoasis/vim-devicons'
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
