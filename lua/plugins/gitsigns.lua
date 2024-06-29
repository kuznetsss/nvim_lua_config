return {
  {
    'lewis6991/gitsigns.nvim',
    config = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        ']c',
        function()
          require('gitsigns').next_hunk()
        end,
      },
      {
        '[c',
        function()
          require('gitsigns').prev_hunk()
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
  }
}
