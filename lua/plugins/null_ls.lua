return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazty = true,
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.diagnostics.teal,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.formatting.stylua,
      },
    }
  end,
}
