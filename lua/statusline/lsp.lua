local lsp_status = require('lsp-status')
local lsp_signs = require('common').signs
local format = require('statusline.common').format

local M = {}

M.get_diagnostics = function()
    local diagnostics = lsp_status.diagnostics(vim.api.nvim_get_current_buf())
    local result = ''
    if diagnostics.warnings ~= 0 then
        result = result .. format(
            lsp_signs.Warning .. diagnostics.warnings .. ' ',
            'FixedLineLspWarning'
        )
    else
        result = result .. '   '
    end
    if diagnostics.errors ~= 0 then
        result = result .. format(
            lsp_signs.Error .. diagnostics.errors .. ' ',
            'FixedLineLspError'
        )
    else
        result = result .. '   '
    end
    if diagnostics.info ~= 0 then
        result = result .. format(
            lsp_signs.Information .. diagnostics.info .. ' ',
            'FixedLineLspInfo'
        )
    else
        result = result .. '   '
    end
    if diagnostics.hints ~= 0 then
        result = result .. format(
            lsp_signs.Hint .. diagnostics.hints .. ' ',
            'FixedLineLspHint'
        )
    else
        result = result .. '   '
    end

    return result
end

return M
