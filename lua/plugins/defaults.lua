local try_require = require('common').try_require
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
        "-j=8",
        "--header-insertion=never"
    }
}

local plugins = {
    signify = 'mhinz/vim-signify'
}

default['lsp_cmd'] = lsp_cmd
default['plugins'] = plugins
local local_patch = try_require('plugins.local')
if local_patch then
    default = local_patch(default)
end

return default
