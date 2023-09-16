return {
  {
    'folke/noice.nvim',
    event = 'VimEnter',
    config = true,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },

  {
    'stevearc/dressing.nvim',
    opts = {
      input = { enabled = false },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    -- branch = 'v3',
    -- config = function()
    --   require('ibl').setup {}
    -- end,
  },
}
