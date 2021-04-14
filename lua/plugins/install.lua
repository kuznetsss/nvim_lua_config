local use = require('packer').use
require('packer').startup( function()
    use { 'wbthomason/packer.nvim', opt = true }
    -- LSP
    use 'neovim/nvim-lspconfig'
    use { 'hrsh7th/nvim-compe',
        config = function()
            vim.o.completeopt = "menuone,noinsert,noselect"
            vim.o.shortmess = vim.o.shortmess .. 'c'
            require'compe'.setup {
                documentation = true,
                autocomplete = true,
                    source = {
                        path = true;
                        buffer = true;
                        calc = false;
                        vsnip = false;
                        nvim_lsp = true;
                        nvim_lua = true;
                        spell = true;
                        tags = true;
                        snippets_nvim = false;
                        treesitter = false;
                    }
            }
        end
    }
    use { 'glepnir/lspsaga.nvim',
        config = function()
            require 'lspsaga'.init_lsp_saga {
                use_saga_diagnostic_sign = true,
                error_sign = '',
                warn_sign = '',
                hint_sign = '',
                infor_sign = '',
                code_action_icon = ' ',
                code_action_keys = { quit = 'q',exec = '<CR>' },
                finder_action_keys = {
                    open = '<CR>', vsplit = 's', split = 'i',
                    quit = 'q', scroll_down = '<C-f>',
                    scroll_up = '<C-b>' -- quit can be a table
                },
                definition_preview_icon = '  ',
                -- 1: thin border | 2: rounded border | 3: thick border
                border_style = 1
            }
        end
    }
    use { 'nvim-lua/lsp-status.nvim',
        config = function()
            require('lsp-status').register_progress()
        end
    }
    -- Syntax hightlight
    use { 'nvim-treesitter/nvim-treesitter',
        run = function() vim.cmd('TSUpdate') end,
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = "maintained",
                highlight = { enable = true }
            }
        end
    }
    -- Vim wiki
    use { 'vimwiki/vimwiki',
        config = function()
            vim.g.vimwiki_list = {
                {path = '~/Documents/vimwiki/', syntax = 'markdown', ext = '.md'}
            }
        end,
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
    use 'glepnir/zephyr-nvim'
    use { 'marko-cerovac/material.nvim',
    	requires = { 'tjdevries/colorbuddy.nvim' },
        config = function()
            vim.g.material_style = "darker"
            --require('colorbuddy').colorscheme('material')
        end
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
    use { 'lukas-reineke/indent-blankline.nvim',
        branch = 'lua',
    }
-- Status line
    use { 'datwaft/bubbly.nvim',
        config = function()
            vim.g.bubbly_statusline = {
                'mode',
                'path',
                'signify',

                'divisor',
                'lsp_status.messages',
                'divisor',

                'lsp_status.diagnostics',
                'total_buffer_number',
                'filetype',
                'progress'
            }
            vim.g.bubbly_symbols = {
               path = {
                  readonly = 'RO',
                  unmodifiable = '',
                  modified = '+',
               },
               signify = {
                  added = '+%s', -- requires 1 '%s'
                  modified = ' %s', -- requires 1 '%s'
                  removed = '-%s', -- requires 1 '%s'
               },
               lsp_status = {
                 diagnostics = {
                    error = ' %d',
                    warning = ' %d',
                    hint = ' %d',
                    info = ' %d',
                 },
              },

            }
        end
    }
-- File explorer
    use { 'kyazdani42/nvim-tree.lua',
        config = function()
            --vim.g.nvim_tree_auto_open = 1
        end
    }
-- Vim script plugins ------------------
-- Fuzzy finder
   use { 'junegunn/fzf.vim',
        config = function()
            vim.g.fzf_command_prefix = 'Fzf'
        end,
        requires = { 'junegunn/fzf' }
    }
-- Highliht VCS changes
    use { require'plugins.defaults'['plugins']['signify'],
        config = function()
            vim.g.signify_sign_add = '+'
            vim.g.signify_sign_delete = '-'
            vim.g.signify_sign_change = ''
        end
    }
-- -----------------Haven't refactored yet
    use 'preservim/nerdcommenter'
    use 'mhinz/vim-startify'
    -- Git plugin
    use 'tpope/vim-fugitive'
    -- Indent line display
    use 'iamcco/markdown-preview.vim'
end
)
