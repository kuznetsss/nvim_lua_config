local jjui_terminal
local claude_terminal

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
    -- {
    --   '<A-t>',
    --   function()
    --     local pathStr = vim.api.nvim_buf_get_name(0)
    --     local path = require('plenary.path'):new(pathStr)
    --     if not path:is_path() then
    --       vim.notify('Current buffer is not a file', vim.log.levels.WARN)
    --       return
    --     end
    --     vim.cmd.ToggleTerm('dir=' .. path:parent():expand())
    --   end,
    --   mode = 'n',
    -- },
    {
      '<leader>jj',
      function()
        jjui_terminal = jjui_terminal
            or require('toggleterm.terminal').Terminal:new {
              cmd = 'jjui',
              display_name = 'jjui',
              direction = 'float',
              close_on_exit = true,
              hidden = true,
              count = 128,
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
    -- {
    --   '<leader>cl',
    --   function()
    --     claude_terminal = claude_terminal
    --         or require('toggleterm.terminal').Terminal:new {
    --           cmd = 'claude',
    --           display_name = 'claude',
    --           direction = 'vertical',
    --           close_on_exit = true,
    --           hidden = true,
    --           count = 127,
    --           on_open = function()
    --             vim.cmd.wincmd 'H'
    --             vim.schedule(function()
    --               vim.wo.winfixwidth = false
    --               vim.wo.winfixheight = false
    --               vim.cmd.wincmd '='
    --             end)
    --             vim.cmd 'startinsert'
    --             vim.keymap.set('t', '<C-j>', function()
    --               claude_terminal:toggle()
    --             end, { buffer = 0 })
    --           end,
    --         }
    --     claude_terminal:toggle()
    --   end,
    -- },
  },
}
