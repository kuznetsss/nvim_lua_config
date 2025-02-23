return {
  {
    'kuznetsss/meadow.nvim',
    priority = 1000,
    dev = true,
    config = function()
      require('meadow').setup {}
      vim.cmd.colorscheme 'meadow'
    end,
  },
  {
    'folke/tokyonight.nvim',
  },
  {
    'neanias/everforest-nvim',
  },
  {
    'brenoprata10/nvim-highlight-colors',
    config = true,
  },
  {
    'folke/noice.nvim',
    event = 'VimEnter',
    config = {
      routes = {
        {
          filter = {
            event = 'lsp',
            kind = 'progress',
            cond = function(message)
              local client = vim.tbl_get(message.opts, 'progress', 'client')
              return client == 'null-ls'
            end,
          },
          opts = { skip = true },
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
  {
    'kuznetsss/fixedline.nvim',
    config = true,
  },
}
