return {
  'folke/persistence.nvim',
  config = true,
  event = 'BufReadPre',
  keys =
  {
    { '<leader>ss', function() require('persistence').load() end },
  }
}
