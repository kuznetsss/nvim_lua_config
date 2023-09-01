-- DONE: Run one command and populate its output to quickfix, be able to kill it
-- DONE: Toggle quickfix
-- Save history and allow telescope to look through history
-- Save history into a shada (or some right file) to save it between sessions
-- Run multiple commands simultaneously
-- Read commands from some file and be able to choose from it or run something new
-- Implement custom buffer instead of quickfix
-- Thanks to @ii14 and @ooesili
local M = {}

local Job = require 'plenary.job'

local previousArgs = {
  command = nil,
  cwd = nil,
}

local runningJob = nil
local qfWindow = nil

local settings = {
  window_height = 10,
  shell = 'bash',
}

local function is_directory(path)
  local dir_stat = vim.loop.fs_stat(path)
  return dir_stat and dir_stat.type == 'directory'
end

local function askForCmd()
  local cmd = nil
  vim.ui.input({
    prompt = 'Command: ',
    default = previousArgs.command,
    completion = 'shellcmd',
  }, function(input)
    cmd = input
  end)
  return cmd
end

local function askForDir()
  local dir = nil
  vim.ui.input({
    prompt = 'Directory to run: ',
    default = previousArgs.cwd or vim.fn.getcwd(),
    completion = 'dir',
  }, function(input)
    dir = input
  end)
  return dir
end

local function isQfWindowVisible()
  return qfWindow and vim.api.nvim_win_is_valid(qfWindow)
end

function M.showQfWindow(activate)
  activate = activate or true
  local previousWindowId = vim.api.nvim_get_current_win()
  if not isQfWindowVisible() then
    vim.cmd.copen()
    vim.cmd.wincmd 'J'
    qfWindow = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_height(qfWindow, settings.window_height)
  end
  if not activate then
    vim.api.nvim_set_current_win(previousWindowId)
  end
end

function M.closeQfWindow()
  if isQfWindowVisible() then
    vim.api.nvim_win_close(qfWindow, false)
    qfWindow = nil
  end
end

function M.toggleQfWindow()
  if qfWindow and vim.api.nvim_win_is_valid(qfWindow) then
    M.closeQfWindow()
  else
    M.showQfWindow(true)
  end
end

local function writeToQf(data)
  vim.schedule(function()
    -- TODO: move cursor to bottom only if it is now at the bottom
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

  cmd = cmd or askForCmd()
  if not cmd then
    vim.notify('Empty command provided', vim.log.levels.WARN)
    return
  end

  dir = dir or askForDir()
  if not dir or not is_directory(dir) then
    vim.notify('Directory ' .. dir .. " doesn't exist", vim.log.levels.WARN)
    return
  end

  runningJob = Job:new {
    command = settings.shell,
    args = { '-c', cmd },
    cwd = dir,
    on_start = function()
      vim.cmd.update()
      clearQf()
      writeToQf('Running ' .. cmd)
      M.showQfWindow()
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
    on_exit = function(_, code)
      writeToQf('Command ' .. cmd .. ' finished with code ' .. code)
      runningJob = nil
      previousArgs.command = cmd
      previousArgs.cwd = dir
    end,
  }
  runningJob:start()
end

function M.repeat_command()
  M.run_command(previousArgs.command, previousArgs.cwd)
end

function M.stop_command()
  if not runningJob then
    vim.notify 'No running command'
    return
  end
  if runningJob.pid then
    runningJob:shutdown(1, 9)
  else
    runningJob = nil
  end
end

vim.keymap.set('n', '<F5>', function()
  M.repeat_command()
end)
vim.keymap.set('i', '<F5>', function()
  M.repeat_command()
end)
vim.keymap.set('n', '<F6>', function()
  M.run_command()
end)
vim.keymap.set('i', '<F6>', function()
  M.run_command()
end)
vim.keymap.set('n', '<F7>', function()
  M.stop_command()
end)
vim.keymap.set('i', '<F7>', function()
  M.stop_command()
end)
vim.keymap.set('n', '<F8>', function()
  M.toggleQfWindow()
end)
vim.keymap.set('i', '<F8>', function()
  M.toggleQfWindow()
end)

return M
