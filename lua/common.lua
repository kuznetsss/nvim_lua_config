local M = {}

function M.save_file()
    local current_buffer = vim.api.nvim_get_current_buf()
    local buftype = vim.api.nvim_buf_get_option(current_buffer, 'buftype')
    if buftype == '' then
        vim.cmd('update')
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
        print('Something went wrong')
        return nil
    end
    return result
end

M.signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

M.map = function(mode, mapping, command, expr, noremap)
    local options = {
        expr = expr or false,
        noremap = noremap or true,
        silent = true
    }
    vim.api.nvim_set_keymap(mode, mapping, command, options)
end

return M
