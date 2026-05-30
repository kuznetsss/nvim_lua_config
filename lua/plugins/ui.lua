return {
  {
    'kuznetsss/meadow.nvim',
    priority = 1000,
    -- dev = true,
    config = function()
      require('meadow').setup {}
      vim.cmd.colorscheme 'meadow'
    end,
  },
  {
    'folke/tokyonight.nvim',
  },
  {
    'neanias/everforest-nvim',
  },
  {
    'brenoprata10/nvim-highlight-colors',
    config = true,
  },
  {
    'rachartier/tiny-cmdline.nvim',
    init = function()
      vim.o.cmdheight = 0
      require('tiny-cmdline').setup {
        menu_col_offset = 3,
        native_types = {},
        on_reposition = require('tiny-cmdline').adapters.blink,
      }
    end,
  },
  {
    'kuznetsss/fixedline.nvim',
    config = true,
  },
}
