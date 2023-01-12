-- Run one command and populate its output to quickfix, be able to kill it
-- Save history and allow telescope to look through history
-- Save history into a shada (or some right file) to save it between sessions
-- Run multiple commands simultaneously
-- Read commands from some file and be able to choose from it or run something new
-- Thanks to @ii14 and @ooesili
local M = {}

local previousArgs = {
    command = nil,
    cwd = nil,
}

local runningJob = nil
local Job = require 'plenary.job'

local settings = {
    window_height = 10,
    shell = 'bash',
}

local function ask_for_cmd()
    local cmd = nil
    vim.ui.input({
        prompt = 'Command: ',
        default = previousArgs.command,
        complete = 'shellcmd',
    }, function(input)
        cmd = input
    end)
    return cmd
end

local function ask_for_dir()
    local dir = nil
    vim.ui.input({
        prompt = 'Directory to run: ',
        default = previousArgs.cwd or vim.fn.getcwd(),
        complete = 'dir',
    }, function(input)
        dir = input
    end)
    return dir
end

local function show_qf_list()
    vim.cmd.copen()
end

local function writeToQf(data)
    vim.schedule(function()
        vim.fn.setqflist({}, 'a', { lines = { data } })
        vim.cmd.cbottom()
    end)
end

local function clearQf()
    vim.schedule(function()
        vim.fn.setqflist({}, 'r')
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
            clearQf()
            writeToQf('Running ' .. cmd)
            show_qf_list()
        end,
        on_stdout = function(err, data)
            if err then
                writeToQf(err)
            end
            if data then
                writeToQf(data)
            end
        end,
        on_stderr = function(err, data)
            if err then
                writeToQf(err)
            end
            if data then
                writeToQf(data)
            end
        end,
        on_exit = function(code)
            writeToQf('Command ' .. cmd .. ' finished with code ' .. code)
            runningJob = nil
        end,
    }
    runningJob:start()
    previousArgs.command = cmd
    previousArgs.cwd = dir
end

function M.stop_command()
    if not runningJob then
        vim.notify("No running command")
        return
    end
    runningJob:shutdown(1, 9)
end

return M
