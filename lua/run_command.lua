-- TODO: don't allow to run multiple commands
-- TODO: check run error
-- TODO: save all before run command
-- TODO: remove vertical column from buffer
local M = {}

local pid = nil
local buffer = nil
local window = nil
local DEFAULT_HEIGHT = 10

local function create_buffer()
    if buffer then
        vim.api.nvim_buf_set_option(buffer, 'modifiable', true)
        vim.api.nvim_buf_set_lines(buffer, 0, -1, false, {})
        vim.api.nvim_buf_set_option(buffer, 'modifiable', false)
        return buffer
    end
    local b = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(b, '[RunCommand]')
    vim.api.nvim_buf_set_option(b, 'modifiable', false)
    return b
end

local function open_window()
    if window and vim.api.nvim_win_is_valid(window) then
        return window
    end

    vim.cmd([[botright split]])
    window = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_height(window, DEFAULT_HEIGHT)
    if not buffer then
        buffer = create_buffer()
    end
    vim.api.nvim_win_set_buf(window, buffer)
    -- map <C-c> to kill
    return window
end

function M.toggle_window()
    if window and vim.api.nvim_win_is_valid(window) then
        vim.api.nvim_win_close(window, false)
    else
        window = open_window()
    end
end

local function run_command(cmd, args, dir)
    buffer = create_buffer()
    window = open_window()
    local cmdStr = 'Running ' .. cmd
    for _, arg in ipairs(args) do
        cmdStr = cmdStr .. ' ' .. arg
    end

    vim.api.nvim_buf_set_option(buffer, 'modifiable', true)
    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, {cmdStr, 'In '..dir, ''})
    vim.api.nvim_buf_set_option(buffer, 'modifiable', false)
    local linesNumber = vim.api.nvim_buf_line_count(buffer)
    vim.api.nvim_win_set_cursor(window, {linesNumber, 1})
    local out = vim.loop.new_pipe(false)
    local cerr = vim.loop.new_pipe(false)
    local handle = nil
    handle, pid = vim.loop.spawn(
        cmd,
        {
            args = args,
            cwd = dir,
            stdio = {nil, out, cerr}
        },
        vim.schedule_wrap(function()
            out:read_stop()
            cerr:read_stop()
            out:close()
            cerr:close()
            handle:close()

            vim.api.nvim_buf_set_option(buffer, 'modifiable', true)
            vim.api.nvim_buf_set_lines(buffer, -1, -1, false, {'Done '..cmd})
            vim.api.nvim_buf_set_option(buffer, 'modifiable', false)
            local linesNumber = vim.api.nvim_buf_line_count(buffer)
            vim.api.nvim_win_set_cursor(window, {linesNumber, 1})
        end)
    )
    local on_read = function(err, data)
        if err then
            print('Error', error)
        end
        if data then
            local lines = vim.split(data, "\n")
            vim.schedule(function()
                vim.api.nvim_buf_set_option(buffer, 'modifiable', true)
                vim.api.nvim_buf_set_lines(buffer, -1, -1, false, lines)
                vim.api.nvim_buf_set_option(buffer, 'modifiable', false)
                local linesNumber = vim.api.nvim_buf_line_count(buffer)
                vim.api.nvim_win_set_cursor(window, {linesNumber, 1})
            end)
        end
    end
    out:read_start(on_read)
    cerr:read_start(on_read)
end

local previousArgs = {}

function M.run(fargs)
    vim.cmd([[silent! wall]])
    if not fargs or #fargs == 0 then
        if #previousArgs ~= 0 then
            run_command(unpack(previousArgs))
            return
        end
        print('RunCommand no args provided')
        return
    end
    local cmd = nil
    local args = {}
    local cwd = nil

    for _, a in ipairs(fargs) do
        if not cwd and vim.startswith(a, 'cwd=') then
            cwd = a:sub(5)
        elseif not cmd then
            cmd = a
        else
            table.insert(args, a)
        end
    end
    cwd = vim.fn.expand(cwd)
    cwd = cwd or vim.loop.cwd()
    previousArgs = {cmd, args, cwd}

    run_command(cmd, args, cwd)
end

function M.kill()
    pid = tonumber(pid)
    if not pid then return end
    vim.loop.kill(pid, 'SIGKILL')
    vim.api.nvim_buf_set_option(buffer, 'modifiable', true)
    vim.api.nvim_buf_set_lines(buffer, -1, -1, false, {'Killed'})
    vim.api.nvim_buf_set_option(buffer, 'modifiable', false)
end

local function init()
    vim.api.nvim_command(
        [[command! -nargs=* -complete=shellcmd RunCommand lua require'run_command'.run({<f-args>})]]
    )
    vim.api.nvim_command(
        [[command! -nargs=0 RunCommandKill lua require'run_command'.kill()]]
    )
    vim.api.nvim_command(
        [[command! -nargs=0 RunCommandToggleWindow lua require'run_command'.toggle_window()]]
    )
end

init()

return M
