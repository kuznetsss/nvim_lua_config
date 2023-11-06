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
  },
  { 'kyazdani42/nvim-tree.lua', config = true },
  {
    'zbirenbaum/copilot.lua',
    config = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    'rest-nvim/rest.nvim',
    config = true,
  },
}
