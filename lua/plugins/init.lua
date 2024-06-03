return {
  'neovim/nvim-lspconfig',
  {
    'folke/neodev.nvim',
    config = true,
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
    'MaximilianLloyd/lazy-reload.nvim',
    opts = {},
  },
  {
    'ziontee113/icon-picker.nvim',
    config = true,
  },
}
