return {
  'zbirenbaum/copilot.lua',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = false,
      },
      panel = {
        enabled = false,
      },
    }
    require('copilot.command').disable()
  end,
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
      desc = 'Toggle copilot',
    },
  },
  cmd = 'Copilot',
}
