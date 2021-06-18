local M = {}

function M.nvim_tree_find_toggle()
  local view = require'nvim-tree.view'
  if view.win_open() then
    view.close()
  else
    vim.cmd("NvimTreeFindFile")
  end
end

return M
