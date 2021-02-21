local M = {}

function M.set_option(scope, key, value)
    vim[scope][key] = value
    if scope ~= 'o' then vim.o[key] = value end
end

function M.save_file()
    local current_buffer = vim.api.nvim_get_current_buf()
    local buftype = vim.api.nvim_buf_get_option(current_buffer, 'buftype')
    if buftype == '' then
        vim.cmd('update')
    end
end

return M
