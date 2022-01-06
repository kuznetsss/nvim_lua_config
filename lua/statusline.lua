local lsp_status = require('lsp-status')

local modes = {
    n = 'NORMAL',
    v = 'VISUAL',
    i = 'INSERT',
    R = 'REPLACE',
    t = 'TERMINAL',
    c = 'COMMAND',
    ['!'] = 'SHELL',
}

local get_mode = function()
    local mode = vim.fn.mode()
    local mode_text = modes[mode] or mode
    return mode_text
end

local get_file_name = function()
    local result = ''
    if vim.opt_local.readonly:get() then
        result = result .. 'RO '
    end
    result = result .. '%f'
    if not vim.opt_local.modifiable:get() then
        result = result .. ' NM '
    end

    if vim.opt_local.modified:get() then
        result = result .. '+'
    end
    return result
end

local get_vcs_status = function()
    local result = ''
    local status = vim.b.gitsigns_status_dict
    if not status then
        return result
    end
    local add = function(icon, value)
        if value ~= 0 then
            result = result .. icon .. value
        else
            result = result .. '   '
        end
    end
    add(' ', status.added)
    add(' ', status.changed)
    add(' ', status.removed)
    return result
end

local last_lsp_message = ''
local allow_update_lsp_message = true

local get_lsp_messages = function()
    local messages = lsp_status.messages()
    if not allow_update_lsp_message then
        return last_lsp_message
    end
end

local get_buffers_number = function()
    return ' ' .. #vim.fn.getbufinfo({buflisted = 1})
end

local get_filetype = function()
    return vim.opt_local.filetype:get()
end

local get_progress = function()
    return '%p%% %l : %c'
end

function _G.make_statusline()
    return string.format(
        ' %s %s    %s %s %s %s %s ',
        get_mode(),
        get_file_name(),
        get_vcs_status(),
        '%=',
        get_buffers_number(),
        get_filetype(),
        get_progress()
    )
end

local set_statusline = function()
    vim.cmd([[setlocal statusline=%!v:lua.make_statusline()]])
end

set_statusline()
-- MODE [RO] [NM] FILENAME [+] [VCS STATUS]     [LSP_CLIENT + MESSAGES]    [LSP_DIAGNOSTICS] OPENED_BUFFERS  FILETYPE PROGRESS
