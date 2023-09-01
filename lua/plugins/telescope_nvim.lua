return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-dap.nvim',
  },
  config = function()
    require('telescope').load_extension 'dap'
  end,
}
