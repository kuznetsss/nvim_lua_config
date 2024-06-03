return {
  'zbirenbaum/copilot.lua',
  config = {
    suggestion = {
      enabled = false,
    },
    panel = {
      enabled = false,
    },
  },
  keys = {
    {
      '<leader>co',
      function()
        if not vim.g.copilot_enabled then
          vim.g.copilot_enabled = false
        end
        vim.g.copilot_enabled = not vim.g.copilot_enabled
        if vim.g.copilot_enabled then
          require('copilot.command').enable()
        else
          require('copilot.command').disable()
        end
      end,
      'Toggle copilot',
    },
  },
}
