vim.opt.conceallevel = 0
vim.opt_local.spell = true
vim.opt_local.spelllang = 'en,ru'

if require('zk.util').notebook_root(vim.fn.expand '%:p') ~= nil then
  local nmap_util = require('utils').nmap
  local nmap = function(lhs, rhs)
    nmap_util(lhs, rhs, { buffer = true })
  end
  local zk_commands = require 'zk.commands'

  nmap('<C-p>', function()
    zk_commands.get 'ZkNotes' { sort = { 'modified' } }
  end)

  nmap('<leader>zt', function()
    zk_commands.get 'ZkTags' ()
  end)

  nmap('<CR>', function()
    vim.lsp.buf.definition()
  end)
end
