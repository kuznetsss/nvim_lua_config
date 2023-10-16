local lspconfig = require 'lspconfig'

for k, v in pairs(require('utils').signs) do
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

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
  capabilities = capabilities,
}
lspconfig.clangd.setup {
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
    '-j=6',
    '--header-insertion=never',
    '--offset-encoding=utf-16',
  },
  log_level = vim.lsp.protocol.MessageType.Log,
  highlight = {
    enable = true,
    lsRanges = true,
  },
  filetypes = { 'h', 'hh', 'c', 'cc', 'cpp', 'objc', 'objcpp' },
  init_options = { clangdFileStatus = true },
  capabilities = capabilities,
}
lspconfig.pylsp.setup {
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
require('lspconfig').yamlls.setup {
  capabilities = capabilities,
}

require('zk').setup {
  picker = 'telescope',
  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { 'zk', 'lsp' },
      name = 'zk',
    },
    auto_attach = {
      enabled = true,
      filetypes = { 'markdown' },
    },
  },
}

require('lspconfig').cmake.setup {
  capabilities = capabilities,
}

require('lspconfig').gopls.setup {
  capabilities = capabilities,
}

require('lspconfig').rust_analyzer.setup {
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

require('lspconfig').ansiblels.setup {
  capabilities = capabilities,
}
require('lspconfig').nixd.setup {
  capabilities = capabilities,
}
