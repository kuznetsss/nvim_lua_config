local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = require('plugins.defaults')['dap']['lldb-vscode'],
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      return vim.fn.input('Input args: ')
    end,
    initCommands = {'command source ~/.lldbinit'}
  }
}
dap.configurations.c = dap.configurations.cpp
