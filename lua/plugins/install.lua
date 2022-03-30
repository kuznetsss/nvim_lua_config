local use = require('packer').use
require('packer').startup( function()
    use { 'wbthomason/packer.nvim', opt = true }
    -- LSP
    use 'neovim/nvim-lspconfig'
    use { 'jose-elias-alvarez/null-ls.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.teal
                }
            })
        end
    }
    use { 'hrsh7th/nvim-cmp',
        requires = {
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
            local compare = require('cmp.config.compare')
            local lspkind = require 'lspkind'
            cmp.setup{
                mapping = {
                    ['<C-d>'] = cmp.mapping(
                        cmp.mapping.scroll_docs(-4),
                        { 'i', 'c' }
                    ),
                    ['<C-f>'] = cmp.mapping(
                        cmp.mapping.scroll_docs(4),
                        { 'i', 'c' }
                    ),
                    ['<C-Space>'] = cmp.mapping(
                        cmp.mapping.complete(),
                        { 'i', 'c' }
                    ),
                    ['<C-e>'] = cmp.mapping({
                      i = cmp.mapping.abort(),
                      c = cmp.mapping.close(),
                    }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(
                        cmp.mapping.select_next_item(), { 'i', 's' }
                    ),
                    ['<S-Tab>'] = cmp.mapping(
                        cmp.mapping.select_prev_item(), { 'i', 's' }
                    ),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'nvim_lsp' },
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
                        compare.recently_used,
                        compare.kind,
                        compare.length,
                        compare.sort_text,
                        compare.order,
                    }
                },
                experimental = { ghost_text = true },
            }
            require('nvim-autopairs').setup()
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done())
        end
    }
    use { 'tami5/lspsaga.nvim',
        config = function()
            local signs = require"common".signs
            require 'lspsaga'.init_lsp_saga {
                use_saga_diagnostic_sign = true,
                error_sign = signs.Error,
                warn_sign = signs.Warning,
                hint_sign = signs.Hint,
                infor_sign = signs.Information,
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
    use { 'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use { 'folke/trouble.nvim',
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            local signs = require"common".signs
            require("trouble").setup {
                signs = {
                    -- icons / text used for a diagnostic
                    error = signs.Error,
                    warning = signs.Warning,
                    hint = signs.Hint,
                    information = signs.Information,
                    other = " "
                }
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
                ignore_install = { "ocamllex", 'devicetree', 'gdscript', 'elixir'},
                highlight = { enable = true },
                indent = { enable = true }
            }
        end
    }
    -- ZettelKasten
    use { "mickael-menu/zk-nvim",
        -- config is in lsp.lua
    }
    -- Improve quickfix
    use { 'kevinhwang91/nvim-bqf',
        config = function()
            require('bqf').setup({
                preview = {auto_preview = false}
            })
        end
    }
    -- Close buffer
    use 'ojroques/nvim-bufdel'

-- colorschemes
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
-- File explorer
    use { 'kyazdani42/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup{
                --vim.g.nvim_tree_auto_open = 1
                disable_netrw = false,
            }
        end
    }
    use { 'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'}
    }
-- Highliht git changes
    use { --'lewis6991/gitsigns.nvim',
        '/home/kuzns/software/gitsigns.nvim_with_arc_support',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('gitsigns').setup()
        end
    }
-- Latex
    use 'lervag/vimtex'

-- Vim script plugins ------------------
-- Spell checker
    use { 'kamykn/spelunker.vim',
        config = function()
            vim.cmd('set nospell')
            vim.g.spelunker_check_type = 2
        end
    }
    use 'iamcco/markdown-preview.vim'
-- -----------------Haven't refactored yet
    use 'mhinz/vim-startify'
    -- Git plugin
    use 'tpope/vim-fugitive'
end
)
