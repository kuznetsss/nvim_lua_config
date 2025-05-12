local nmap = require('utils').nmap
local imap = require('utils').imap

-- Disable help by F1
nmap('<F1>', '<Nop>')
imap('<F1>', '<Nop>')

nmap('<C-h>', '<C-o>')
nmap('<C-l>', '<C-i>')

vim.keymap.set(
  't',
  '<Esc>',
  '"<C-\\><C-n>"',
  { noremap = true, expr = true, silent = true }
)

vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd.tabnew()
  vim.cmd.edit(vim.lsp.get_log_path())
end, {})

nmap('<Space><Space>', function()
  vim.cmd.w()
end)

------ LSP
nmap('K', vim.lsp.buf.hover)
nmap('<leader>lh', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)
nmap('<leader>ld', function()
  local config = vim.diagnostic.config()
  if config.virtual_text then
    vim.diagnostic.config { virtual_text = false }
  else
    vim.diagnostic.config {
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = ' ',
      },
    }
  end
end)

nmap('[e', function()
  vim.diagnostic.goto_prev { severity = { min = vim.diagnostic.severity.WARN } }
end)
nmap(']e', function()
  vim.diagnostic.goto_next { severity = { min = vim.diagnostic.severity.WARN } }
end)
nmap('[h', function()
  vim.diagnostic.goto_prev { severity = { max = vim.diagnostic.severity.INFO } }
end)
nmap(']h', function()
  vim.diagnostic.goto_next { severity = { max = vim.diagnostic.severity.INFO } }
end)

nmap('<leader>qf', vim.lsp.buf.code_action)
nmap('<leader>rn', vim.lsp.buf.rename)
nmap('<leader>cf', function()
  vim.lsp.buf.format { async = true }
end)
