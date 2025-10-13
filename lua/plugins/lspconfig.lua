local setup_ls = function()
  for k, v in pairs(require('utils').signs) do
    local hl = 'DiagnosticSign' .. k
    vim.fn.sign_define(hl, { text = v, texthl = hl, numhl = hl })
  end

  local border = {
    { '🭽', 'FloatBorder' },
    { '▔', 'FloatBorder' },
    { '🭾', 'FloatBorder' },
    { '▕', 'FloatBorder' },
    { '🭿', 'FloatBorder' },
    { '▁', 'FloatBorder' },
    { '🭼', 'FloatBorder' },
    { '▏', 'FloatBorder' },
  }
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
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
    float = { border = border },
  }

  -- Add additional capabilities supported by nvim-cmp
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  vim.lsp.config.lua_ls = {
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
  vim.lsp.enable('lua_ls')

  vim.lsp.config.clangd = {
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
  vim.lsp.enable('clangd')

  vim.lsp.config.pylsp = {
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
  vim.lsp.enable('pylsp')

  vim.lsp.config.yamlls = {
    capabilities = capabilities,
  }
  vim.lsp.enable('yamlls')

  vim.lsp.config.cmake = {
    capabilities = capabilities,
  }
  vim.lsp.enable('cmake')

  vim.lsp.config.gopls = {
    capabilities = capabilities,
  }
  vim.lsp.enable('gopls')

  vim.lsp.config.rust_analyzer = {
    on_init = function(client)
      client.config.settings['rust-analyzer'].cargo = { features = 'all', all_targets = true }
    end,
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = false,
        },
        checkOnSave = {
          command = 'clippy',
        },
      },
    },
  }
  vim.lsp.enable('rust_analyzer')

  vim.lsp.config.nixd = {
    capabilities = capabilities,
    settings = {
      nixd = {
        nixpkgs = {
          expr = 'import <nixpkgs> { }',
        },
        formatting = {
          command = { 'nixfmt' },
        },
        options = {
          home_manager = {
            expr = '(builtins.getFlake ("~/.config/nix/)).homeConfigurations.h.options',
          },
        },
      },
    },
  }
  vim.lsp.enable('nixd')

  vim.lsp.config.html = {
    capabilities = capabilities,
  }
  vim.lsp.enable('html')

  vim.lsp.config.ts_ls = {
    capabilities = capabilities,
    filetypes = { 'javascript', 'typescript' },
  }
  vim.lsp.enable('ts_ls')

  vim.lsp.config.tinymist = {
    capabilities = capabilities,
  }
  vim.lsp.enable('tinymist')
end

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  config = setup_ls,
}
