local M = {}

function M.save_file()
  local filename = vim.api.nvim_buf_get_name(0)
  if
      not vim.bo.readonly
      and vim.bo.buftype == ''
      and string.len(filename) > 0
  then
    vim.cmd.update()
  end
end

M.signs = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' ',
}

M.map = function(mode, lhs, rhs, options)
  options =
      vim.tbl_extend('force', { noremap = false, silent = true }, options or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

M.nmap = function(lhs, rhs, options)
  M.map('n', lhs, rhs, options)
end

M.imap = function(lhs, rhs, options)
  M.map('i', lhs, rhs, options)
end

return M
