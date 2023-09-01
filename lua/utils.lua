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

M.press_key = function(keys)
  vim.api.nvim_feedkeys(keys, 'm', true)
end

M.map = function(mode, lhs, rhs, options)
  options =
    vim.tbl_extend('force', { noremap = false, silent = true }, options or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

M.local_map = function(buffer, mode, mapping, command, expr, noremap)
  local options = {
    expr = expr or false,
    noremap = noremap or true,
    silent = true,
  }
  vim.api.nvim_buf_set_keymap(buffer, mode, mapping, command, options)
end

M.nmap = function(lhs, rhs, options)
  M.map('n', lhs, rhs, options)
end

M.imap = function(lhs, rhs, options)
  M.map('i', lhs, rhs, options)
end

return M
