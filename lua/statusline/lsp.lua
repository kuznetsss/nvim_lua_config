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

local spinner_frames = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣾", "⣽" }
local timer = vim.loop.new_timer()
local show_new_messages_allowed = true
local last_messages = nil

M.get_status = function()
    local messages = lsp_status.messages()
    if not show_new_messages_allowed then
        return last_messages
    end
    local contents = {}
    for _, msg in ipairs(messages) do
        local parsed_message = ""
        if msg.progress then
            parsed_message = parsed_message .. msg.title
            if msg.message then
                parsed_message = parsed_message .. " " .. msg.message
            end

            if msg.percentage then
                parsed_message =
                    parsed_message .. " (" .. math.floor(msg.percentage + 0.5) .. "%%)"
            end

            if msg.spinner then
                parsed_message = spinner_frames[(msg.spinner % #spinner_frames) + 1] .. " " .. parsed_message
            end
        elseif msg.status then
            parsed_message = parsed_message .. msg.content
        else
            parsed_message = parsed_message .. msg.content
        end
        if contents[msg.name] == nil then
            contents[msg.name] = parsed_message
        else
            contents[msg.name] = contents[msg.name] .. ", " .. parsed_message
        end
    end
    local result_str = ""
    for name, msg in pairs(contents) do
        result_str = result_str .. name .. ": " .. msg .. " | "
    end
    last_messages = format(result_str:sub(1, -4) , 'FixedLineBackground')
    show_new_messages_allowed = false
    timer:start(500, 0, function() show_new_messages_allowed = true end)
    return last_messages
end

return M
