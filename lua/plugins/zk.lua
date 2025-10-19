local notes_dir = vim.fn.resolve(vim.env.HOME .. '/Documents/zk')

return {
  'zk-org/zk-nvim',
  version = '*',
  ft = 'markdown',
  lazy = true,
  config = function()
    require('zk').setup {
      picker = 'snacks_picker',
    }
  end,
  keys = {
    {
      '<leader>zk',
      function()
        require('zk.commands').get 'ZkNotes' {
          notebook_path = notes_dir,
          sort = { 'modified' },
        }
      end,
      desc = 'Search in Zk',
    },
    {
      '<leader>zn',
      function()
        require('zk.commands').get 'ZkNew' { notebook_path = notes_dir }
      end,
    },
    {
      '<leader>zd',
      function()
        require('zk.commands').get 'ZkNew' {
          notebook_path = notes_dir,
          dir = notes_dir .. '/Daily',
          group = 'daily',
        }
      end,
    },
  },
}
