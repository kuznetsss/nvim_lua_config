local M = {}

function M.save_file()
    local filename = vim.api.nvim_buf_get_name(0)
    if
        not vim.bo.readonly
        and vim.bo.buftype == ''
        and string.len(filename) > 0
    then
        vim.cmd 'update'
    end
end

function M.try_require(module_name)
    local status, module = pcall(require, module_name)
    if status then
        return module
    end
    return nil
end

function M.try_run(f)
    local status, result = pcall(f)
    if not status then
        print 'Something went wrong'
        return nil
    end
    return result
end

M.signs = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
}

M.map = function(mode, mapping, command, expr, noremap)
    local options = {
        expr = expr or false,
        noremap = noremap or true,
        silent = true,
    }
    vim.api.nvim_set_keymap(mode, mapping, command, options)
end
M.local_map = function(buffer, mode, mapping, command, expr, noremap)
    local options = {
        expr = expr or false,
        noremap = noremap or true,
        silent = true,
    }
    vim.api.nvim_buf_set_keymap(buffer, mode, mapping, command, options)
end

return M
