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
      return vim.split(vim.fn.input('Input args: '), ' ')
    end,
    initCommands = {'command source ~/.lldbinit'}
  },
  {
      -- If you get an "Operation not permitted" error using this, try disabling YAMA:
      --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      name = "Attach to process",
      type = 'lldb',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
      request = 'attach',
      pid = require('dap.utils').pick_process,
      args = {},
  }
}
dap.configurations.c = dap.configurations.cpp
