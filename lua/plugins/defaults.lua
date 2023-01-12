local try_require = require('common').try_require
local default = {}

local lsp_cmd = {
    sumneko_lua = {
        'lua-language-server',
    },
    clangd = {
        'clangd',
        '--background-index',
        '-j=8',
        '--header-insertion=never',
    },
}

local plugins = {
    signify = 'mhinz/vim-signify',
}

default.lsp_settings = {
    pylsp = {
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
        }
    },
}

default['lsp_cmd'] = lsp_cmd
default['plugins'] = plugins
default.dap = {
    ['lldb-vscode'] = 'lldb-vscode',
}
local local_patch = try_require 'plugins.local'
if local_patch then
    default = local_patch(default)
end

return default
