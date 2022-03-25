-- MODE [RO] [NM] FILENAME [+] [VCS STATUS]     [LSP_CLIENT + MESSAGES]    [LSP_DIAGNOSTICS] OPENED_BUFFERS  FILETYPE PROGRESS

local lsp = require('statusline.lsp')
local format = require('statusline.common').format

local modes = setmetatable(
    {
        n = {' NORMAL ', 'FixedLineNormalMode'},
        v = {' VISUAL ', 'FixedLineVisualMode'},
        i = {' INSERT ', 'FixedLineInsertMode'},
        R = {' REPLACE ', 'FixedLineReplaceMode'},
        t = {' TERMINAL ', 'FixedLineTerminalMode'},
        c = {' COMMAND ', 'FixedLineCommandMode'},
        ['!'] = {' SHELL ', 'FixedLineShellMode'},
    },
    { __index = function(key) return {key, 'Normal'} end }
)


local get_mode = function()
    local mode = vim.fn.mode()
    local text, hl = unpack(modes[mode])
    return format(text, hl) .. format('', 'FixedLineBackground')
end

local get_file_name = function()
    local result = ''
    if vim.opt_local.readonly:get() then
        result = result .. format('RO ', 'FixedLineReadOnly')
    end
    if not vim.opt_local.modifiable:get() then
        result = result .. format('NM ', 'FixedLineModifiable')
    end
    result = result .. format('%t', 'FixedLineBackground')

    if vim.opt_local.modified:get() then
        result = result .. format(' +', 'FixedLineModified')
    end
    return result
end

local get_vcs_status = function()
    local result = ''
    local status = vim.b.gitsigns_status_dict
    if not status then
        return result
    end
    local add = function(icon, value, hi)
        if value and value ~= 0 then
            result = result .. format(icon .. value .. '  ', hi)
        else
            result = result .. '   '
        end
    end
    add(' ', status.added, 'FixedLineGitAdd')
    add(' ', status.changed, 'FixedLineGitChange')
    add(' ', status.removed, 'FixedLineGitDelete')
    return result
end

--[[ local last_lsp_message = ''
local allow_update_lsp_message = true

local get_lsp_messages = function()
    local messages = lsp_status.messages()
    if not allow_update_lsp_message then
        return last_lsp_message
    end
end ]]

local get_buffers_number = function()
    return format(' ' .. #vim.fn.getbufinfo({buflisted = 1}), 'FixedLineBufNum')
end

local get_filetype = function()
    return format(vim.opt_local.filetype:get(), 'FixedLineFileType')
end

local progress = format(' %l : %c    %p%% ', 'FixedLineProgress')

function _G.make_fixedline()
    return string.format(
        '%s%s %s  %s%s%s %s %s   %s    %s %s',
        format('', 'FixedLineBackground'),
        get_mode(),
        get_file_name(),
        get_vcs_status(),
        '%=',
        lsp.get_status(),
        '%=',
        lsp.get_diagnostics(),
        get_buffers_number(),
        get_filetype(),
        progress
    )
end

local M = {}

M.set_statusline = function()
    vim.cmd([[autocmd BufWinEnter,WinEnter * setlocal statusline=%!v:lua.make_fixedline()]])
end

M.set_statusline()

return M

