return {
  'nvim-lua/lsp-status.nvim',
  lazy = true,
  config = function()
    require('lsp-status').register_progress()
  end,
}
