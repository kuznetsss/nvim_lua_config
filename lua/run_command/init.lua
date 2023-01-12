-- Run one command and populate its output to quickfix, be able to kill it
-- Save history and allow telescope to look through history
-- Save history into a shada (or some right file) to save it between sessions
-- Run multiple commands simultaneously
-- Read commands from some file and be able to choose from it or run something new
local M = {}

local previousArgs = {
    command = nil,
    cwd = nil
}

local runningJob = nil
local quickfixBufferId = vim.fn.getqflist({ qfbufnr = 1 }).qfbufnr


local Job = require 'plenary.job'

local settings = {
    window_height = 10,
    shell = 'bash'
}

local function ask_for_cmd()
    local cmd = nil
    vim.ui.input({
        prompt = 'Command: ',
        default = previousArgs.command,
        complete = 'shellcmd',
    }, function(input) cmd = input end)
    return cmd
end

local function ask_for_dir()
    local dir = nil
    vim.ui.input({
        prompt = 'Directory to run: ',
        default = previousArgs.cwd or vim.fn.getcwd(),
        complete = 'dir',
    }, function(input) dir = input end)
    return dir
end

local function show_qf_list()
    vim.cmd.copen()
end

local function writeToQf(data)
    vim.schedule_wrap(function()
        local start = vim.api.nvim_buf_line_count(quickfixBufferId)
        vim.api.nvim_buf_set_option(quickfixBufferId, 'modifiable', true)
        vim.api.nvim_buf_set_lines(quickfixBufferId, start, -1, false, { data })
        vim.api.nvim_buf_set_option(quickfixBufferId, 'modifiable', false)
    end)
end

function M.run_command(cmd, dir)
    if runningJob ~= nil then
        vim.notify('Job is already running', vim.log.levels.INFO)
        return
    end

    cmd = cmd or ask_for_cmd()
    dir = dir or ask_for_dir()

    runningJob = Job:new {
        command = settings.shell,
        args = { '-c', cmd },
        cwd = dir,
        on_start = function()
            vim.notify('starting')
            writeToQf('Running ' .. cmd)
            show_qf_list()
        end,
        on_stdout = function(err, data)
            vim.notify('on_stdout')
            if err then
                writeToQf(err)
            end
            if data then
                writeToQf(data)
            end
        end,
        on_stderr = function(err, data)
            vim.notify('on_stderr')
            if err then
                writeToQf(err)
            end
            if data then
                writeToQf(data)
            end
        end,
        on_exit = function(code, signal)
            vim.notify('on_exit')

            if signal then
                writeToQf('Command ' .. cmd .. ' finished with signal ' .. signal)
            else
                writeToQf('Command ' .. cmd .. ' finished with code ' .. code)
            end
        end
    }
    runningJob:start()
    previousArgs.command = cmd
    previousArgs.cwd = dir
end

return M
