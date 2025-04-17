return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = 'all',
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = false, -- set to `false` to disable one of the mappings
          node_incremental = '+',
          scope_incremental = '_',
          node_decremental = '-',
        },
      },
    }
  end,
}
