local M = {}

M.format = function(text, hl)
    return string.format(
        '%%#%s#%s',
        hl,
        text
    )
end

return M
