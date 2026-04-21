return {
  {
    'dlyongemallo/diffview.nvim',
    version = '*',
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
