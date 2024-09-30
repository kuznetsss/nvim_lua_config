return {
  {
    'rest-nvim/rest.nvim',
    ft = 'http',
    tag = 'v1.2.1',
    config = function()
      require('rest-nvim').setup()
    end,
    keys = {
      {'<leader>r', function() vim.cmd[[Rest run]] end},
    }
  },
}
