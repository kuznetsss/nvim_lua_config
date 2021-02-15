local lspconfig = require('lspconfig')
local defaults = require('plugins.defaults')
local lsp_status = require('lsp-status')

local custom_attach = function(client)
    require('completion').on_attach(client)
    lsp_status.on_attach(client)
end

lspconfig.sumneko_lua.setup{
    cmd = defaults['lsp_cmd']['sumneko_lua'],
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
            completion = { keywordSnippet = "Disable", },
            diagnostics = {
                enable = true,
                globals = {
                    "vim", "describe", "it",
                    "before_each", "after_each"
                }
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    [vim.fn.stdpath("config")..'/lua'] = true,
                }
            }
        }
    },
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities
}
lspconfig.clangd.setup {
    cmd = defaults['lsp_cmd']['clangd'],
    log_level =  vim.lsp.protocol.MessageType.Log,
    highlight = {
        enable = true,
        lsRanges = true
    },
    filetypes = { 'h', 'hh', 'c', 'cc', 'cpp', 'objc', 'objcpp' },
    -- on_init = function to handle changing offsetEncoding
    -- root_dir = root_pattern('compile_commands.json', 'compile_flags.txt', '.git') or dirname
    on_attach = custom_attach,
    handlers = lsp_status.extensions.clangd.setup(),
    init_options = { clangdFileStatus = true },
    capabilities = lsp_status.capabilities
}
lspconfig.pyls.setup{
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities
}
