local nvim_tree_toggle = function()
  require('nvim-tree.api').tree.toggle { find_file = true, update_root = true }
end

return {
  'kyazdani42/nvim-tree.lua',
  config = true,
  keys = {
    { '<F2>', nvim_tree_toggle, mode = 'n' },
    {
      '<F2>',
      function()
        vim.cmd.stopinsert()
        nvim_tree_toggle()
      end,
      mode = 'i',
    },
  },
  cmd = {
    'NvimTreeToggle',
    'NvimTreeFocus',
  },
}
