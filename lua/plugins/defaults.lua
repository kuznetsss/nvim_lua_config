local try_require = require('common').try_require
local default = {}

local lsp_cmd = {
    sumneko_lua = {
        '/usr/bin/lua-language-server',
        '-E',
        '/usr/share/lua-language-server/main.lua',
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

default['lsp_settings'] = {
    pylsp = {
        configurationSources = { 'flake8', 'yapf' },
        plugins = {
            flake8 = { enabled = true },
            mccabe = { enabled = false },
            pycodestyle = { enabled = false },
            pyflakes = { enabled = false },
            pylint = { enabled = false },
            rope_completion = { enabled = false },
            yapf = { enabled = true },
        },
    },
}

default['lsp_cmd'] = lsp_cmd
default['plugins'] = plugins
default.dap = {
    ['lldb-vscode'] = '/usr/bin/lldb-vscode',
}
local local_patch = try_require 'plugins.local'
if local_patch then
    default = local_patch(default)
end

return default
