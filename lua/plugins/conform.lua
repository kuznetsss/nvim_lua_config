return {
  'stevearc/conform.nvim',
  opts = {
    default_format_opts = {
      lsp_format = 'fallback',
    },
  },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true }
      end,
      'Format current file',
    },
  },
}
