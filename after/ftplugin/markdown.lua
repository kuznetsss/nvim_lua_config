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
    zk_commands.get 'ZkTags'()
  end)

  nmap('<CR>', function()
    vim.lsp.buf.definition()
  end)
  nmap('<leader>tg', function()
    Snacks.picker.grep { dirs = { vim.fn.expand '%:h' } }
  end)

  vim.api.nvim_buf_create_user_command(0, 'ZkDelete', function()
    local current_file = vim.fn.expand '%:t'
    if vim.fn.confirm('Delete file ' .. current_file, '&Yes\n&No', 2) == 1 then
      vim.system({ 'trash', vim.fn.expand '%' }, {}, function(obj)
        if obj.code ~= 0 then
          vim.notify(
            'Error deleting file ' .. current_file .. ': ' .. obj.stderr,
            vim.log.levels.ERROR
          )
        else
          vim.notify('Deleted ' .. current_file)
          vim.schedule(function() Snacks.bufdelete() end)
        end
      end)
    end
  end, {})
end
