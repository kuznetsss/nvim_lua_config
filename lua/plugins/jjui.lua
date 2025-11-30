return {
  'mrdwarf7/lazyjui.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = true,
  keys = {
    {
      '<Leader>jj',
      function()
        require('lazyjui').open()
      end,
    },
  },
}
