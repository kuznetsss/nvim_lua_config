return {
  'neovim/nvim-lspconfig',
  {
    'numToStr/Comment.nvim',
    config = true,
  },
  {
    'folke/neodev.nvim',
    config = true,
  },
  'mickael-menu/zk-nvim',

  { 'kyazdani42/nvim-tree.lua', config = true },
  {
    'zbirenbaum/copilot.lua',
    config = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = { markdown = true, help = true, gitcommit = true },
    },
  },
  {
    'rest-nvim/rest.nvim',
    config = function()
      require('rest-nvim').setup {
      }
    end,
  },
  {
    'MaximilianLloyd/lazy-reload.nvim',
    opts = {},
  },
  {
    'ziontee113/icon-picker.nvim',
    config = true,
  },
  {
    'kuznetsss/delegate.nvim',
    config = true,
    dev = true,
  },
}
