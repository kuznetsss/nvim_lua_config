local lspconfig = require('lspconfig')
local defaults = require('plugins.defaults')
local lsp_status = require('lsp-status')

local custom_attach = function(client)
    lsp_status.on_attach(client)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
      spacing = 4,
      prefix = ' ',
    },
    signs = true,
    -- Disable a feature
    update_in_insert = false,
  }
)

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
require('cmp_nvim_lsp').update_capabilities(capabilities)

-- from lsp_status
capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

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
    capabilities = capabilities
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
    capabilities = capabilities
}
lspconfig.pylsp.setup{
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = defaults.lsp_settings.pylsp
}
require'lspconfig'.yamlls.setup{}

require("zk").setup{
picker = "telescope",
    lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            on_attach = custom_attach
        },
        auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
        },
    },
}
