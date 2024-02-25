return {
  'nvimtools/none-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'davidmh/cspell.nvim' },
  config = function()
    local null_ls = require 'null-ls'
    local cspell = require 'cspell'
    null_ls.setup {
      sources = {
        null_ls.builtins.diagnostics.teal,
        null_ls.builtins.diagnostics.selene,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.statix,
        cspell.diagnostics.with {
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
          disabled_filetypes = { 'markdown' },
          diagnostic_config = {
            underline = true,
            virtual_text = false,
            signs = false,
            update_in_insert = false,
            severity_sort = false,
          },
        },
        cspell.code_actions,
      },
    }
  end,
}
