-- selene: allow(undefined_variable)

return {
  'snacks.nvim',
  opts = {
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
          },
        },
      },
    },
  },
  keys = {
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      'LSP references picker',
    },

    {
      '<leader>ds',
      function()
        Snacks.picker.lsp_symbols()
      end,
      'LSP symbols picker',
    },
    {
      '<leader>dS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      'LSP workplace symbols picker',
    },
    {
      '<C-y>',
      function()
        Snacks.picker.buffers()
      end,
      'Buffers picker',
    },

    {
      '<leader>tc',
      function()
        Snacks.picker.commands()
      end,
      'Vim commands picker',
    },
    {
      '<leader>th',
      function()
        Snacks.picker.command_history()
      end,
      'Vim commands history picker',
    },
    {
      '<leader>tH',
      function()
        Snacks.picker.highlights()
      end,
      'Highlights picker',
    },
    {
      '<leader>tk',
      function()
        Snacks.picker.keymaps()
      end,
      'Keymaps picker',
    },
    {
      '<leader>tr',
      function()
        Snacks.picker.registers()
      end,
      'Registers picker',
    },
    {
      '<leader>tm',
      function()
        Snacks.picker.help()
      end,
      'Help picker',
    },
    {
      '<leader>ti',
      function()
        Snacks.picker.highlights()
      end,
      'Highlights picker',
    },
    {
      '<leader>tg',
      function()
        Snacks.picker.grep()
      end,
      'Grep picker',
    },
    {
      '<leader>tw',
      function()
        Snacks.picker.grep_word()
      end,
      'Grep word picker',
    },
    {
      '<leader>ts',
      function()
        Snacks.picker.spelling()
      end,
      'Spelling picker',
    },
    {
      '<leader>tq',
      function()
        Snacks.picker.qflist()
      end,
      'Quickfix list picker',
    },
    {
      '<leader>tf',
      function()
        Snacks.picker.oldfiles()
      end,
      'Old files picker',
    },
    {
      '<C-p>',
      function()
        Snacks.picker.smart {
          multi = { 'buffers', 'files' },
        }
      end,
      'Smart picker',
    },
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      'Git branches picker',
    },
  },
}
