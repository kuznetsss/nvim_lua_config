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
  {
    'kuznetsss/meadow.nvim',
    priority = 1000,
    config = function()
      require('meadow').setup {}
      vim.cmd.colorscheme 'meadow'
    end,
    dev = true,
  },
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
    config = true,
  },
  {
    'MaximilianLloyd/lazy-reload.nvim',
    opts = {},
  },
  {
    'ziontee113/icon-picker.nvim',
    config = true,
  }
}
