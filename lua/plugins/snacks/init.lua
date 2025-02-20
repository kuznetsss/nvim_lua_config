return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  import = 'plugins.snacks',
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    image = { enabled = true },
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
