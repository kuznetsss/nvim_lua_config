return {
  'folke/snacks.nvim',
  version = '*',
  priority = 999,
  lazy = false,
  import = 'plugins.snacks',
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    bufdelete = { enabled = true },
    image = { enabled = true },
    input = { enabled = false },
    notifier = { enabled = false },
  },
  keys = {
    {
      '<C-w>x',
      function()
        require('snacks').bufdelete()
      end,
      'Delete current buffer',
    },
  },
}
