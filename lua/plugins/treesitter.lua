return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = 'main',
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(event)
        local lang = vim.treesitter.language.get_lang(event.match)
            or event.match
        local ts = require 'nvim-treesitter'
        if
            vim.list_contains(
              ts.get_installed(),
              vim.treesitter.language.get_lang(lang)
            )
        then
          vim.treesitter.start()
        end
      end,
    })
  end,
  -- event = { 'BufReadPre', 'BufNewFile' },
  -- config = function()
  --   require('nvim-treesitter.configs').setup {
  --     ensure_installed = 'all',
  --     highlight = { enable = true },
  --     indent = { enable = true },
  --     incremental_selection = {
  --       enable = true,
  --       keymaps = {
  --         init_selection = false, -- set to `false` to disable one of the mappings
  --         node_incremental = '+',
  --         scope_incremental = '_',
  --         node_decremental = '-',
  --       },
  --     },
  --   }
  -- end,
}
