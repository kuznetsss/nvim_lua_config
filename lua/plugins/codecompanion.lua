local overrides = require('utils').override('local.codecompanion', {
  acp = {},
  adapter = 'copilot',
})

return {
  'olimorris/codecompanion.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    adapters = {
      http = {
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = {
              model = {
                default = 'claude-sonnet-4.5',
              },
            },
          })
        end,
      },
      acp = overrides.acp,
    },
    display = {
      action_palette = { provider = 'snacks' },
    },
    strategies = {
      chat = {
        adapter = overrides.adapter,
        keymaps = {
          send = {
            modes = { n = '<CR>', i = '<C-CR>' },
          },
          clear = {
            modes = { n = '<C-l>', i = '<C-l>' },
          },
        },
      },
      inline = {
        adapter = 'copilot',
      },
      cmd = {
        adapter = 'copilot',
      },
    },
  },
  cmd = {
    'CodeCompanion',
    'CodeCompanionChat',
    'CodeCompanionCmd',
    'CodeCompanionActions',
  },
  keys = {
    {
      '<leader>cc',
      function()
        vim.cmd.CodeCompanionChat 'toggle'
      end,
      desc = 'Toggle CodeCompanion Chat',
    },
    {
      '<leader>ca',
      function()
        vim.cmd.CodeCompanionActions()
      end,
      desc = 'Open CodeCompanion Actions',
    },
  },
}
