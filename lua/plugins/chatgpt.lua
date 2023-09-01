return {
  'jackMort/ChatGPT.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  event = 'VeryLazy',
  opts = {
    chat = {
      keymaps = {
        close = { '<C-q>' },
      },
    },
    openai_params = {
      max_tokens = 3000,
    },
  },
}
