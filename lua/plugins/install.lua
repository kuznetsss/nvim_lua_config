local packer_bootstrapped = require 'plugins.packer_bootstrap'
local packer = require 'packer'
packer.init {
    compile_path = vim.fn.stdpath 'data'
        .. '/site/pack/loader/start/packer.nvim/plugin/packer.lua',
}

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- LSP
    use 'neovim/nvim-lspconfig'
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            local null_ls = require 'null-ls'
            null_ls.setup {
                sources = {
                    null_ls.builtins.diagnostics.teal,
                    null_ls.builtins.diagnostics.luacheck,
                    null_ls.builtins.formatting.stylua,
                },
            }
        end,
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'onsails/lspkind-nvim',
            'windwp/nvim-autopairs',
            'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
            'L3MON4D3/LuaSnip', -- Snippets plugin
        },
        config = function()
            local cmp = require 'cmp'
            local compare = require 'cmp.config.compare'
            local lspkind = require 'lspkind'
            local luasnip = require 'luasnip'
            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
                            :sub(col, col)
                            :match '%s'
                        == nil
            end
            cmp.setup {
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
                    ['<C-e>'] = cmp.mapping {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    },
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'buffer' },
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
                    },
                },
                experimental = { ghost_text = true },
            }
            require('nvim-autopairs').setup()
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    }
    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            local signs = require('common').signs
            require('trouble').setup {
                signs = {
                    -- icons / text used for a diagnostic
                    error = signs.Error,
                    warning = signs.Warning,
                    hint = signs.Hint,
                    information = signs.Information,
                    other = ' ',
                },
            }
        end,
    }
    use {
        'nvim-lua/lsp-status.nvim',
        config = function()
            require('lsp-status').register_progress()
        end,
    }
    -- Syntax hightlight
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            vim.cmd 'TSUpdate'
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                ignore_install = {
                    'ocamllex',
                    'devicetree',
                    'gdscript',
                    'elixir',
                },
                highlight = { enable = true },
                indent = { enable = false },
            }
        end,
    }
    -- Debugging
    use {
        'mfussenegger/nvim-dap',
        requires = {'rcarriga/nvim-dap-ui', 'nvim-telescope/telescope-dap.nvim'}
    }
    use {
        "rcarriga/nvim-dap-ui",
        requires = {"mfussenegger/nvim-dap"},
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
              dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
              dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
              dapui.close()
            end
        end
    }
    -- ZettelKasten
    use {
        'mickael-menu/zk-nvim',
        -- config is in lsp.lua
    }
    -- Improve quickfix
    use {
        'kevinhwang91/nvim-bqf',
        config = function()
            require('bqf').setup {
                preview = { auto_preview = false },
            }
        end,
    }
    -- Close buffer
    use 'ojroques/nvim-bufdel'

    -- colorschemes
    use {
        'kuznetsss/meadow-nvim',
        config = function()
            require('meadow').setup {
                color_value = 80,
                color_saturation = 80,
            }
        end,
    }

    use {
        'nvim-treesitter/playground',
        config = function()
            require('nvim-treesitter.configs').setup {
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
                },
            }
        end,
    }

    -- Draw colors of codes
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({ '*' }, { names = false })
        end,
    }
    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    -- Indent draw
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                char = '|',
                buftype_exclude = { 'terminal' },
            }
        end,
    }
    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup {
                view = { preserve_window_proportions = true },
            }
        end,
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-dap.nvim' },
        config = function()
            require('telescope').load_extension('dap')
        end
    }
    -- Highliht git changes
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup()
        end,
    }
    -- Latex
    use 'lervag/vimtex'

    -- Startup screen
    use {
        'goolord/alpha-nvim',
        config = function()
            require('alpha').setup(require('alpha.themes.startify').config)
        end,
    }
    -- Vim script plugins ------------------
    -- Spell checker
    use {
        'kamykn/spelunker.vim',

        config = function()
            vim.cmd 'set nospell'
            vim.g.spelunker_check_type = 2
        end,
    }
    use 'iamcco/markdown-preview.vim'

    -- -----------------Haven't refactored yet
    -- Git plugin
    use 'tpope/vim-fugitive'

    if packer_bootstrapped then
        packer.sync()
    end
end)

return packer_bootstrapped
