local M = {}

function M.set_option(scope, key, value)
    vim[scope][key] = value
    if scope ~= 'o' then vim.o[key] = value end
end

return M
