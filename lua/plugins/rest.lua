return {
  {
    'rest-nvim/rest.nvim',
    ft = 'http',
    config = function()
      require('rest-nvim').setup()
    end,
    keys = {
      {
        '<leader>r',
        function()
          vim.cmd [[Rest run]]
        end,
        silent = true,
      },
    },
    cmd = { 'Rest' },
  },
}
