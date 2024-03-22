return {
  {
    'rest-nvim/rest.nvim',
    ft = 'http',
    tag = 'v1.2.1',
    config = function()
      require('rest-nvim').setup()
    end,
  },
}
