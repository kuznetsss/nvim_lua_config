return {
  'folke/snacks.nvim',
  priority = 999,
  lazy = false,
  import = 'plugins.snacks',
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    image = { enabled = true },
    input = { enabled = true },
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
