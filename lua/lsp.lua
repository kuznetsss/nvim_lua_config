local lspconfig = require 'lspconfig'
local lsp_status = require 'lsp-status'

for k, v in pairs(require('common').signs) do
  local hl = 'DiagnosticSign' .. k
  vim.fn.sign_define(hl, { text = v, texthl = hl, numhl = hl })
end
vim.diagnostic.config {
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = {
    spacing = 4,
    source = 'if_many',
    prefix = ' ',
  },
}

local custom_attach = function(client)
  lsp_status.on_attach(client)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- from lsp_status
capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      completion = { keywordSnippet = 'Disable' },
      diagnostics = {
        enable = true,
        globals = {
          'vim',
          'describe',
          'it',
          'before_each',
          'after_each',
        },
      },
      workspace = {
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
          [vim.fn.stdpath 'config' .. '/lua'] = true,
        },
      },
    },
  },
  on_attach = custom_attach,
  capabilities = capabilities,
}
lspconfig.clangd.setup {
  cmd = {
    'clangd',
    '--background-index',
    '-j=6',
    '--header-insertion=never',
  },
  log_level = vim.lsp.protocol.MessageType.Log,
  highlight = {
    enable = true,
    lsRanges = true,
  },
  filetypes = { 'h', 'hh', 'c', 'cc', 'cpp', 'objc', 'objcpp' },
  on_attach = custom_attach,
  handlers = lsp_status.extensions.clangd.setup(),
  init_options = { clangdFileStatus = true },
  capabilities = capabilities,
}
lspconfig.pylsp.setup {
  on_attach = custom_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      configurationSources = { 'flake8' },
      plugins = {
        autopep8 = { enabled = false },
        black = { enabled = true },
        flake8 = { enabled = true },
        mccabe = { enabled = true },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        pylint = { enabled = false },
        rope_completion = { enabled = false },
        yapf = { enabled = false },
      },
    },
  },
}
require('lspconfig').yamlls.setup {}

require('zk').setup {
  picker = 'telescope',
  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { 'zk', 'lsp' },
      name = 'zk',
      on_attach = custom_attach,
    },
    auto_attach = {
      enabled = true,
      filetypes = { 'markdown' },
    },
  },
}

require('lspconfig').cmake.setup {
  on_attach = custom_attach,
  capabilities = capabilities,
}

require('lspconfig').gopls.setup {
  on_attach = custom_attach,
  capabilities = capabilities,
}

require('lspconfig').rust_analyzer.setup {
  on_attach = custom_attach,
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        experimental = { enable = true },
        enable = false,
      },
    },
  },
}

require('lspconfig').ansiblels.setup {}
require('lspconfig').nixd.setup {}
