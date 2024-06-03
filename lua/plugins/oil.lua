return {
  'stevearc/oil.nvim',
  keys = {
    {'<leader>o', function() require('oil').toggle_float() end, desc = 'Toggle Oil'},
  },
  opts = {
    default_file_explorer = false,
    -- Id is automatically added at the beginning, and name at the end
    -- See :help oil-columns
    columns = {
      'icon',
      -- "permissions",
      "size",
      "mtime",
    },
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
