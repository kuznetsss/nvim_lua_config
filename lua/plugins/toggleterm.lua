return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  keys = {
    {
      '<C-t>',
      function()
        require('toggleterm').toggle(1)
      end,
      mode = 'n',
    },
    {
      '<C-t>',
      function()
        -- vim.cmd '1ToggleTerm'
        require('toggleterm').toggle(1)
      end,
      mode = 't',
    },
    {
      '<A-t>',
      function()
        local pathStr = vim.api.nvim_buf_get_name(0)
        local path = require('plenary.path'):new(pathStr)
        if not path:is_path() then
          vim.notify('Current buffer is not a file', vim.log.levels.WARN)
          return
        end
        vim.cmd.ToggleTerm('dir=' .. path:parent():expand())
      end,
      mode = 'n',
    },
    {
      '<leader>j',
      function()
        require('toggleterm').toggle(9, 20, nil, 'float', 'jj')
      end
    }
  },
}
