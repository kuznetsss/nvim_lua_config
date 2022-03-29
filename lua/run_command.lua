local M = {}

local lines = {}
local handle
local out = vim.loop.new_pipe(false)
local cerr = vim.loop.new_pipe(false)
M.run = function(cmd, args, dir)
    args = args or {}
    dir = dir or vim.loop.cwd()
    handle = vim.loop.spawn(
        cmd,
        {
            args = args,
            cwd = dir,
            stdio = {nil, out, cerr}
        },
        vim.schedule_wrap(function()
            print'in wrap'
            out:read_stop()
            out:close()
            handle:close()
            vim.fn.setqflist({}, 'r', {title = 'Command', lines = lines})
            vim.api.nvim_command('copen')
            lines = {}
        end)
    )
    local on_read = function(err, data)
        if err then
            print('Error', error)
        end
        if data then
            local vals = vim.split(data, "\n")
            for _, d in pairs(vals) do
                if d ~= "" then
                    table.insert(lines, d)
                end
            end
        end
    end
    vim.loop.read_start(out, on_read)
    vim.loop.read_start(cerr, on_read)
    local s = 'Running' .. cmd
    vim.fn.setqflist({}, 'r', {title = 'Command', lines = {s}})
end

return M
