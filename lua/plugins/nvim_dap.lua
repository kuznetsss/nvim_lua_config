return {
  {
    'mfussenegger/nvim-dap',
    dependecies = {
      'rcarriga/nvim-dap-ui',
      'nvim-telescope/telescope-dap.nvim',
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    dependecies = { 'mfussenegger/nvim-dap' },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}
