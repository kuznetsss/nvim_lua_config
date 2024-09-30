-- Disable auto comment symbols insert
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { '*' },
  callback = function() vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' }) end
})

-- Terminal setup
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = { '*' },
  callback = function()
    vim.cmd.startinsert()
    vim.opt_local.buflisted = false
    vim.opt_local.bufhidden = 'hide'
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
  pattern = '*',
  callback = require('utils').save_file,
})
