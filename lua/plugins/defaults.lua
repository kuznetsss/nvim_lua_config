local default = {}

local lsp_cmd = {
    sumneko_lua = {
        '/usr/bin/lua-language-server',
        '-E',
        '/usr/share/lua-language-server/main.lua'
    },
    clangd = {
        "clangd",
        "--background-index",
        "-j=2",
        "--header-insertion=never"
    }
}

local plugins = {
    signify = 'mhinz/vim-signify'
}

default['lsp_cmd'] = lsp_cmd
default['plugins'] = plugins
local local_patch = require('plugins.local')
default = local_patch(default)

return default
