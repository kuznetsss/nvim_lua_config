local M = {}

function M.nvim_tree_find_toggle()
  local view = require'nvim-tree.view'
  if view.is_visible() then
    view.close()
  else
    vim.cmd("NvimTreeFindFile")
  end
end

return M
