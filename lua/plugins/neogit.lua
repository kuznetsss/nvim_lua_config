return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/snacks.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      require('neogit').setup {
        commit_editor = {
          kind = 'split_below',
        },
        console_timeout = 10000,
      }
    end,
    keys = {
      {
        '<leader>gg',
        function()
          require('neogit').open { kind = 'split' }
        end,
      },
    },
    cmd = 'Neogit',
  },
}
