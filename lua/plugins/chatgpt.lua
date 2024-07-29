return {
  'jackMort/ChatGPT.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    chat = {
      keymaps = {
        close = '<C-q>',
      },
    },
    openai_params = {
      max_tokens = 10000,
      model = 'gpt-4o-mini',
    },
  },
  keys = {
    { '<leader>cg', vim.cmd.ChatGPT },
  },
}
