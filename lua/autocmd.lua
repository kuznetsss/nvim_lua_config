-- Disable auto comment symbols insert
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { '*' },
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
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

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format { bufnr = args.buf }
  end,
})

vim.api.nvim_create_user_command('Undotree', function()
  vim.cmd.packadd 'nvim.undotree'
  vim.cmd.Undotree()
  vim.notify 'lazy undotree'
end, {})

local ignored_clients = { 'null-ls' }
vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or vim.tbl_contains(ignored_clients, client.name) then
      return
    end
    local value = ev.data.params.value
    local status = ({ begin = 'running', report = 'running', ['end'] = 'success' })[value.kind]
    vim.api.nvim_echo({ { value.message or value.title or '' } }, false, {
      id = ('lsp-progress:%d:%s'):format(ev.data.client_id, tostring(ev.data.params.token)),
      kind = 'progress',
      source = client.name,
      title = value.title or '',
      percent = value.percentage,
      status = status,
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'msg',
  callback = function()
    local ui2 = require 'vim._core.ui2'
    local win = ui2.wins and ui2.wins.msg
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_set_option_value(
        'winhighlight',
        'Normal:NormalFloat,FloatBorder:FloatBorder',
        { scope = 'local', win = win }
      )
    end
  end,
})

local ui2 = require 'vim._core.ui2'
local msgs = require 'vim._core.ui2.messages'
local orig_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
  orig_set_pos(tgt)
  if
    (tgt == 'msg' or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg)
  then
    pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
      relative = 'editor',
      anchor = 'NE',
      row = 1,
      col = vim.o.columns - 3,
      border = 'rounded',
    })
  end
end
