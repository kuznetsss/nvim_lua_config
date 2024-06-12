return {
  {
    'kuznetsss/meadow.nvim',
    priority = 1000,
    config = function()
      require('meadow').setup {}
      vim.cmd.colorscheme 'meadow'
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VimEnter',
    config = {
      views = {
        cmdline_input = {
          relative = 'editor',
          position = {
            row = '50%',
            col = '50%',
          },
          size = { min_width = 60 },
        },
      },
      routes = {
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
      },
    },
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
    config = function()
      require('ibl').setup {
        scope = {
          show_start = false,
          show_end = false,
        },
      }
    end,
  },
}
