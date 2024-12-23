local setup_cmp = function()
  require('copilot_cmp').setup()
  local cmp = require 'cmp'
  local compare = require 'cmp.config.compare'

  local lspkind = require 'lspkind'
  lspkind.init {
    symbol_map = {
      Copilot = '',
    },
  }
  local luasnip = require 'luasnip'
  cmp.setup {
    mapping = {
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ['<CR>'] = cmp.mapping.confirm { select = false },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    window = {
      documentation = cmp.config.window.bordered(),
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = {
      { name = 'lazydev' },
      { name = 'copilot' },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lua' },
      { name = 'path' },
      { name = 'buffer' },
      -- { name = 'nvim_lsp_signature_help' }
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
end

return {
  -- 'hrsh7th/nvim-cmp',
  'iguanacucumber/magazine.nvim',
  name = 'nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'onsails/lspkind-nvim',
    'windwp/nvim-autopairs',
    'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
    'L3MON4D3/LuaSnip', -- Snippets plugin
    'zbirenbaum/copilot-cmp',
  },
  enabled = false,
  event = { 'BufReadPre', 'BufNewFile' },
  config = setup_cmp,
}
