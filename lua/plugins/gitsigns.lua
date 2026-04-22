return {
  {
    'lewis6991/gitsigns.nvim',
    config = true,
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        ']c',
        function()
          require('gitsigns').nav_hunk 'next'
        end,
      },
      {
        '[c',
        function()
          require('gitsigns').nav_hunk 'prev'
        end,
      },
      {
        '<leader>gp',
        function()
          require('gitsigns').preview_hunk()
        end,
      },
      {
        '<leader>gr',
        function()
          require('gitsigns').reset_hunk()
        end,
      },
      {
        '<leader>ga',
        function()
          require('gitsigns').stage_hunk()
        end,
      },
    },
  },
}
