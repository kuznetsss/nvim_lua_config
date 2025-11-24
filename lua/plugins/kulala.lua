return {
  'mistweaverco/kulala.nvim',
  keys = {
    {
      '<leader>r',
      function()
        require('kulala').run()
      end,
      desc = 'Send request',
    },
  },
  ft = { 'http', 'rest' },
  opts = {
    global_keymaps = false,
  },
}
