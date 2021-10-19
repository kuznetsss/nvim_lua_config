local use = require('packer').use
require('packer').startup( function()
    use { 'wbthomason/packer.nvim', opt = true }
    -- LSP
    use 'neovim/nvim-lspconfig'
    use { 'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'onsails/lspkind-nvim',
            'windwp/nvim-autopairs',
            'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
            'L3MON4D3/LuaSnip' -- Snippets plugin
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            local compare = require('cmp.config.compare')
            local lspkind = require 'lspkind'
            cmp.setup{
                mapping = {
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<Tab>'] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'nvim_lsp' },
                    --{ name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
                formatting = {
                    format = lspkind.cmp_format(),
                },
                sorting = {
                    comparators = {
                        compare.offset,
                        compare.exact,
                        compare.score,
                        compare.kind,
                        compare.length,
                        compare.sort_text,
                        compare.order,
                    }
                }
            }
            require('nvim-autopairs').setup()
            require("nvim-autopairs.completion.cmp").setup({
                map_cr = true, --  map <CR> on insert mode
                map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
                auto_select = true, -- automatically select the first item
                insert = false, -- use insert confirm behavior instead of replace
                map_char = { -- modifies the function or method delimiter by filetypes
                    all = '(',
                    tex = '{'
                }
            })
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
                code_action_keys = { quit = '<Esc>',exec = '<CR>' },
                finder_action_keys = {
                    open = '<CR>', vsplit = 's', split = 'i',
                    quit = '<Esc>', scroll_down = '<C-f>',
                    scroll_up = '<C-b>' -- quit can be a table
                },
                rename_action_keys = {
                    quit = '<Esc>', exec = '<CR>'  -- quit can be a table
                },
                max_preview_lines = 16,
                definition_preview_icon = '  ',
                border_style = 'round'
            }
        end,
    }
    use { 'nvim-lua/lsp-status.nvim',
        config = function()
            require('lsp-status').register_progress()
        end
    }
    -- Syntax hightlight
    use { 'nvim-treesitter/nvim-treesitter',
        branch = '0.5-compat',
        run = function() vim.cmd('TSUpdate') end,
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = "maintained",
                ignore_install = { "ocamllex", 'devicetree', 'gdscript', 'elixir'},
                highlight = { enable = true },
                indent = { enable = true }
            }
        end
    }
    -- Vim wiki
    use { 'vimwiki/vimwiki',
        config = function()
            vim.g.vimwiki_list = {
                {path = '~/Documents/vimwiki/', syntax = 'markdown', ext = '.md'}
            }
        end
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
    use 'dracula/vim'
    use 'michalbachowski/vim-wombat256mod'
    use { 'tjdevries/gruvbuddy.nvim',
    	requires = { 'tjdevries/colorbuddy.nvim' }
    }
    use 'glepnir/zephyr-nvim'
    use { 'kuznetsss/meadow-nvim',
        config = function()
            require'meadow'.setup {
                color_value = 80,
                color_saturation = 80
            }
        end
        }

    use { 'nvim-treesitter/playground',
        config = function()
            require "nvim-treesitter.configs".setup {
              playground = {
                enable = true,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                  toggle_query_editor = 'o',
                  toggle_hl_groups = 'i',
                  toggle_injected_languages = 't',
                  toggle_anonymous_nodes = 'a',
                  toggle_language_display = 'I',
                  focus_language = 'f',
                  unfocus_language = 'F',
                  update = 'R',
                  goto_node = '<cr>',
                  show_help = '?',
                },
              }
            }
        end
    }


-- Draw colors of codes
    use { 'norcalli/nvim-colorizer.lua',
        config = function()
            require'colorizer'.setup({'*'}, { names = false })
        end
    }
-- Icons
    use 'kyazdani42/nvim-web-devicons'

-- Indent draw
    use { 'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                char = '|',
                buftype_exclude = {'terminal'}
            }
        end
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
            require('nvim-tree').setup()
            --vim.g.nvim_tree_auto_open = 1
        end
    }
    use { 'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
-- Vim script plugins ------------------
-- Spell checker
    use { 'kamykn/spelunker.vim',
        config = function()
            vim.cmd('set nospell')
        end
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
    use 'mhinz/vim-startify'
    -- Git plugin
    use 'tpope/vim-fugitive'
    -- Indent line display
    use 'iamcco/markdown-preview.vim'
end
)
