--[[
nnoremap <leader>r :source ~/.vim/vimrc<CR>
c>-]]
local map = require('utils').map
local nmap = require('utils').nmap
local imap = require('utils').imap
local press_key = require('utils').press_key

-- Disable help by F1
nmap('<F1>', '<Nop>')
imap('<F1>', '<Nop>')

-- nmap('<C-k>', ':bnext<CR>')
-- nmap('<C-j>', ':bprev<CR>')

nmap('<C-t>', function()
  vim.cmd.ToggleTerm()
end)
map('t', '<C-t>', function()
  press_key '<Esc>'
  vim.cmd '1ToggleTerm'
end)
nmap('<A-t>', function()
  local pathStr = vim.api.nvim_buf_get_name(0)
  local path = require('plenary.path'):new(pathStr)
  if not path:is_path() then
    vim.notify('Current buffer is not a file', vim.log.levels.WARN)
    return
  end
  vim.cmd.ToggleTerm('dir=' .. path:parent():expand())
end)

nmap('<C-h>', '<C-o>')
nmap('<C-l>', '<C-i>')

imap('<C-l>', '<C-^>')

vim.keymap.set(
  't',
  '<Esc>',
  '"<C-\\><C-n>"',
  { noremap = true, expr = true, silent = true }
)

vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd.edit(vim.lsp.get_log_path())
end, {})

-- Plugins

------ LSP
local telescope = require 'telescope.builtin'
nmap('gd', vim.lsp.buf.declaration)
nmap('gf', vim.lsp.buf.definition)
nmap('gs', vim.cmd.ClangdSwitchSourceHeader)
nmap('K', vim.lsp.buf.hover)
nmap('gr', telescope.lsp_references)

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

nmap('<leader>ds', telescope.lsp_document_symbols)
nmap('<leader>dS', telescope.lsp_workspace_symbols)
nmap('<leader>qf', vim.lsp.buf.code_action)
nmap('<leader>rn', vim.lsp.buf.rename)
nmap('<leader>cf', function()
  vim.lsp.buf.format { async = true }
end)

-- DAP and debug
nmap('<F10>', require('dap').continue)
nmap('<F11>', require('dap').step_over)
nmap('<F12>', require('dap').step_into)
nmap('<leader>db', require('dap').toggle_breakpoint)

-- Gitsigns
local gs = require 'gitsigns'
nmap(']c', gs.next_hunk)
nmap('[c', gs.prev_hunk)
nmap('<leader>gp', gs.preview_hunk)
nmap('<leader>gr', gs.reset_hunk)
nmap('<leader>ga', gs.stage_hunk)

-- Neogit
local neogit = require 'neogit'
nmap('<leader>gg', function()
  neogit.open { kind = 'split' }
end)

-- DiffView
nmap('<leader>gd', require('diffview').open)

------ nvim-tree
local nvim_tree_toggle = function()
  require('nvim-tree.api').tree.toggle { find_file = true, update_root = true }
end
nmap('<F2>', nvim_tree_toggle)
imap('<F2>', function()
  press_key '<Esc>'
  nvim_tree_toggle()
end)

-- Telescope
nmap('<C-y>', function()
  telescope.buffers { show_all_buffers = true }
end)
nmap('<leader>tc', telescope.commands)
nmap('<leader>th', telescope.command_history)
nmap('<leader>tH', telescope.highlights)
nmap('<leader>tk', telescope.keymaps)
nmap('<leader>tr', telescope.registers)
nmap('<leader>to', telescope.vim_options)
nmap('<leader>tm', telescope.help_tags)
nmap('<leader>ti', telescope.highlights)
nmap('<leader>tg', telescope.live_grep)
nmap('<leader>tw', telescope.grep_string)
nmap('<leader>ts', telescope.spell_suggest)
nmap('<leader>tq', telescope.quickfix)
nmap('<leader>tf', telescope.oldfiles)
nmap('<C-p>', telescope.find_files)
nmap('<leader>gb', telescope.git_branches)
nmap('<leader>gs', telescope.git_stash)
nmap('<leader>gc', telescope.git_commits)

-- zk mappings
--see filetype/markdown.md for more mappings
nmap('<leader>zk', function()
  vim.cmd.cd '~/Documents/zk'
  vim.cmd.edit 'main.md'
end)
nmap('<leader>zc', function()
  vim.cmd.edit '~/Documents/neetcode-zk'
  vim.cmd.edit 'main.md'
end)

-- Lazy mapping
nmap('<leader>ls', require('lazy').sync)
nmap('<leader>lh', require('lazy').home)
nmap('<leader>ll', require('lazy').log)
nmap('<leader>lp', require('lazy').profile)

-- ChatGPT
nmap('<leader>cg', vim.cmd.ChatGPT)

-- Restore session
nmap('<leader>ss', require('persistence').load)
nmap('<leader>sl', function()
  require('persistence').load { last = true }
end)
