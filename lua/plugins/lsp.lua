local lspconfig = require('lspconfig')
local defaults = require('plugins.defaults')
local lsp_status = require('lsp-status')

local custom_attach = function(client)
    --require('completion').on_attach(client)
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
    -- Use a function to dynamically turn signs off
    -- and on, using buffer local variables
    signs = function(bufnr, client_id)
      local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
      -- No buffer local variable set, so just enable by default
      if not ok then
        return true
      end

      return result
    end,
    -- Disable a feature
    update_in_insert = false,
  }
)

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
lspconfig.pylsp.setup{
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities
}
