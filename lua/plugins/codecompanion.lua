return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    adapters = {
      copilot = function()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              default = 'gemini-2.5-pro',
            },
          },
        })
      end,
    },
    display = {
      action_palette = { provider = 'snacks' },
    },
    strategies = {
      chat = {
        adapter = 'copilot',
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
