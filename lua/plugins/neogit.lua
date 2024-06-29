return {
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
