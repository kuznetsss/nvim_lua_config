return {
  'jackMort/ChatGPT.nvim',
  enabled = false,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    openai_params = {
      max_tokens = 4096,
      model = 'gpt-4o-mini',
    },
    openai_edit_params = {
      model = 'gpt-4o-mini',
    },
  },
  cmd = {
    'ChatGPT',
    'ChatGPTRun',
    'ChatGPTActAs',
    'ChatGPTEditWithInstructions',
  },

  keys = {
    { '<leader>cg', vim.cmd.ChatGPT },
  },
}
