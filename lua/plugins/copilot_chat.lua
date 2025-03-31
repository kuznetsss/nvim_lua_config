return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    -- build = 'make tiktoken',                          -- Only on MacOS or Linux
    opts = {
      model = 'claude-3.7-sonnet',
      mappings = {
        complete = {
          insert = '<Tab>',
        },
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-CR>',
        },
      },
      show_help = true, -- Show help text for CopilotChat window
    },
    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatClose',
      'CopilotChatToggle',
      'CopilotChatStop',
      'CopilotChatReset',
      'CopilotChatSave',
      'CopilotChatLoad',
      'CopilotChatPrompts',
      'CopilotChatModels',
      'CopilotChatAgents',
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "CopilotChat" },
    },
  },
}
