local jjui_terminal

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
      '<leader>jj',
      function()
        jjui_terminal = jjui_terminal
            or require('toggleterm.terminal').Terminal:new {
              cmd = 'jjui',
              display_name = 'jjui',
              direction = 'float',
              close_on_exit = true,
              on_open = function()
                vim.cmd 'startinsert'
                vim.keymap.set('t', '<Esc>', '<Esc>', { buffer = 0 })
                vim.keymap.set('t', '<C-j>', function()
                  jjui_terminal:toggle()
                end, { buffer = 0 })
              end,
            }
        jjui_terminal:toggle()
      end,
    },
  },
}
