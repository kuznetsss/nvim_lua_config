return {
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        '<leader>gd',
        function()
          require('diffview').open()
        end,
      },
    },
    cmd = 'DiffviewOpen',
  },
}
