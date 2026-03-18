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
                default = 'claude-sonnet-4.6',
              },
            },
          })
        end,
      },
      acp = overrides.acp,
    },
    display = {
      action_palette = { provider = 'snacks' },
      chat = { show_reasoning = false },
    },
    interactions = {
      cli = {
        agent = 'claude_code',
        agents = {
          claude_code = {
            cmd = 'claude',
            args = {},
            description = 'Claude Code CLI',
            provider = 'terminal',
          },
        },
      },
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
    'CodeCompanionCLI',
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
      '<leader>cl',
      function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].filetype == 'codecompanion_cli' then
            require('codecompanion').toggle()
            return
          end
        end
        vim.cmd.CodeCompanionCLI()
      end,
      desc = 'Toggle CodeCompanion CLI',
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
