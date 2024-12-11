local setup_dap = function()
  local dap = require 'dap'
  dap.defaults.fallback.auto_continue_if_many_stopped = false
  dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-dap',
    name = 'lldb',
  }

  dap.configurations.cpp = {
    {
      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.input(
          'Path to executable: ',
          vim.fn.getcwd() .. '/',
          'file'
        )
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = function()
        return vim.split(vim.fn.input 'Input args: ', ' ')
      end,
      initCommands = { 'command source ~/.lldbinit' },
    },
    {
      -- If you get an "Operation not permitted" error using this, try disabling YAMA:
      --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      name = 'Attach to process',
      type = 'lldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
      request = 'attach',
      pid = require('dap.utils').pick_process,
      args = {},
    },
    {
      name = 'Load core file',
      type = 'lldb',
      request = 'attach',
      program = function()
        return vim.fn.input(
          'Path to executable: ',
          vim.fn.getcwd() .. '/',
          'file'
        )
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      coreFile = function()
        return vim.fn.input('Corefile: ', vim.fn.getcwd() .. '/', 'file')
      end,
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-telescope/telescope-dap.nvim',
      'nvim-neotest/nvim-nio',
    },
    lazy = true,
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        -- dapui.close()
      end
      setup_dap()
      vim.api.nvim_create_user_command('DapUiToggle', function()
        dapui.toggle()
      end, {})
    end,
    keys = {
      {
        '<F10>',
        function()
          require('dap').continue()
        end,
      },
      {
        '<F11>',
        function()
          require('dap').step_over()
        end,
      },
      {
        '<F12>',
        function()
          require('dap').step_into()
        end,
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
      },
    },
    cmd = {
      'DapUiToggle',
    },
  },
}
