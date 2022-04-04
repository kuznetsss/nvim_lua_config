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
    vim.api.nvim_buf_set_option(b, 'modifiable', false)
    return b
end

local function open_window()
    if window and vim.api.nvim_win_is_valid(window) then
        return window
    end

    vim.cmd([[botright split]])
    local w = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_height(w, DEFAULT_HEIGHT)
    -- map <C-c> to kill
    return w
end

local function run_command(cmd, args, dir)
    args = args or {}
    dir = dir or vim.loop.cwd()

    buffer = create_buffer()
    window = open_window()

    vim.api.nvim_buf_set_option(buffer, 'modifiable', true)
    vim.api.nvim_buf_set_lines(buffer, -1, -1, false, {'Running '..cmd})
    vim.api.nvim_buf_set_option(buffer, 'modifiable', false)
    vim.api.nvim_win_set_buf(window, buffer)
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

function M.run(fargs)
    local cmd = nil
    local args = {}
    local cwd = nil

    for _, a in ipairs(fargs) do
        if vim.startswith(a, 'cwd=') then
            cwd = a:sub(5)
        end
        if not cmd then
            cmd = a
        else
            table.insert(args, a)
        end
    end

    run_command(cmd, args, cwd)
end

function M.kill()
    if not pid then return end
    vim.loop.kill(pid, 'SIGKILL')
    print('RunCommand killed')
end

local function init()
    vim.api.nvim_command(
        [[command! -nargs=+ -complete=shellcmd RunCommand lua require'run_command'.run({<f-args>})]]
    )
    vim.api.nvim_command(
        [[command! -nargs=0 RunCommandKill lua require'run_command'.kill()]]
    )
end

init()

return M
