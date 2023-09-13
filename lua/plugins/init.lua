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
    'kuznetsss/meadow-nvim',
    priority = 1000,
    config = function()
      require('meadow').setup {}
    end,
  },
  { 'kyazdani42/nvim-tree.lua', config = true },
}
