-- Run one command and populate its output to quickfix, be able to kill it
-- Save history and allow telescope to look through history
-- Save history into a shada (or some right file) to save it between sessions
-- Run multiple commands simultaneously
-- Read commands from some file and be able to choose from it or run something new
local M = {}

local DEFAULT_HEIGHT = 10

local previousArgs = {}
local runningJob = nil

local Job = require 'plenary.job'

local function run_command()
    if runningJob ~= nil then
        vim.notify('Job is already running', vim.log.levels.INFO)
        return
    end
    cmd = vim.ui.input({
        prompt = 'Command: ',
        complete = 'shellcmd',
    }, function(input)
        return vim.split ' '
    end)
    runningJob = Job:new {
        command = cmd[1],
        args = {table.unpack(cmd, 2)},
        cwd = dir,
        on_stdout = function() end,
        on_stderr = function() end,
    }
end

return M
