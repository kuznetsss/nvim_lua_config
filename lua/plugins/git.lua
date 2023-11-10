return {
  {
    'lewis6991/gitsigns.nvim',
    config = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  'tpope/vim-fugitive',
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',         -- required
      'nvim-telescope/telescope.nvim', -- optional
      'sindrets/diffview.nvim',        -- optional
    },
    config = function()
      require('neogit').setup {
        commit_editor = {
          kind = 'split',
        },
      }
    end,
  },
  -- Github plugins
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = true,
  },
  {
    'Almo7aya/openingh.nvim',
    config = true,
  },
}
