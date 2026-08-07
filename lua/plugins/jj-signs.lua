return {
  {
    dir = '~/Documents/lua/jj-signs.nvim/',
    enabled = false,
    opts = {
      on_attach = function(bufnr)
        local jj = require 'jj-signs'
        local map = function(mode, key, fn, desc)
          vim.keymap.set(mode, key, fn, { buffer = bufnr, desc = desc })
        end
        map('n', ']c', function()
          jj.nav_hunk 'next'
        end, 'Next JJ hunk')
        map('n', '[c', function()
          jj.nav_hunk 'prev'
        end, 'Prev JJ hunk')
        map('n', '<leader>gp', jj.preview_hunk, 'Preview JJ hunk')
        map('n', '<leader>gr', jj.restore_hunk, 'Restore hunk from @-')
        map('n', '<leader>gR', jj.reset_buffer, 'Reset buffer to @-')
      end,
    },
  },
}
