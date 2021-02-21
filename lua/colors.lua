local set_option = require'common'.set_option
-- Support true color
set_option('o', 'termguicolors', true)

set_option('o', 'background', 'dark')
vim.cmd('syntax on')

vim.cmd('colorscheme zephyr')

-- Color right part in different color
--vim.cmd('highlight ColorColumn guibg=#313233')

local signcolumn_color = '#282828'
-- Adjust background of column left of line numbers
--vim.cmd('highlight SignColumn guibg=' .. signcolumn_color)

-- Adjust LspSaga colors
local lspsaga_colors = "highlight DiagnosticError guifg='#9f0000' guibg='"
    .. signcolumn_color .. "' gui='bold'\n" ..
    "highlight DiagnosticWarning guifg='#ff8900' guibg='"
    .. signcolumn_color .. "' gui='bold'\n" ..
    "highlight DiagnosticInformation guifg='#000080' guibg='"
    .. signcolumn_color .. "' gui='bold'\n" ..
    "highlight DiagnosticHint guifg='#aafa00' guibg='"
    .. signcolumn_color .. "' gui='bold'"
vim.api.nvim_exec(lspsaga_colors, false)

-- Adjust Signify colors
local signify_colors_command =
    "highlight SignifySignAdd guifg='#00be00' guibg='" .. signcolumn_color
    ..  "' gui='bold'\n" ..
    "highlight SignifySignDelete guifg='#aa0000' guibg='" .. signcolumn_color
    ..  "' gui='bold'\n"..
    "highlight SignifySignChange guifg='#ffff00' guibg='" .. signcolumn_color
    ..  "' gui='bold'\n"
vim.api.nvim_exec(signify_colors_command, false)

-- Adjust statusline colors
vim.g.bubbly_palette = {
    background = "Black",
    foreground = "White",
    black = "Black",
    light_black = '#222222',
    red = '#ae0000',
    dark_red = '#600000',
    light_green = '#428a00',
    dark_green = '#004000',
    orange = '#faaa00',
    dark_orange = '#9a4a00',
    yellow = '#e2ef41',
    blue = '#0024EC',
    dark_blue = '#001A9B',
    light_blue = '#308DAD',
    purple = "Magenta",
    cyan = "Cyan",
    white = '#dddddd',
    lightgrey = "LightGrey",
    darkgrey = "Grey",
}
vim.g.bubbly_colors = {
    default = 'red',
    foreground = 'foreground',
    background = 'background',

    mode = {
        -- uses by default 'background' as the foreground color.
        normal = {background = 'light_green', foreground = 'dark_green'},
        insert = {background = 'white', foreground = 'light_blue'},
        visual = {background = 'orange', foreground = 'dark_orange'},
        visualblock = {background = 'yellow', foreground = 'dark_orange'},
        command = 'yellow',
        terminal = {background = 'light_black', foreground = 'light_green'},
        replace = 'red',
        default = 'white'
    },
    path = {
        readonly = { background = 'background', foreground = 'red' },
        unmodifiable = { background = 'background', foreground = 'foreground' },
        path = {background = 'background', foreground = 'white'},
        modified = { background = 'green', foreground = 'dark_green' },
    },
    branch = 'purple',
    signify = {
        added = { background = 'background' , foreground = 'green' },
        modified = { background = 'background' , foreground = 'yellow' },
        removed = { background = 'background' , foreground = 'red' },
    },
    paste = 'red',
    coc = {
        error = 'red',
        warning = 'yellow',
        status = { background = 'lightgrey', foreground = 'foreground' },
    },
    builtinlsp = {
        diagnostic_count = {
            error = { background = 'background', foreground = 'red' },
            warning = { background = 'background', foreground = 'orange' },
        },
        current_function = 'purple',
    },
    filetype = { background = 'background', foreground = 'light_blue' },
    progress = {
        rowandcol = { background = 'darkgrey', foreground = 'background' },
        percentage = { background = 'darkgrey', foreground = 'background' },
    },
    tabline = {
        active = 'blue',
        inactive = 'white',
    },
    total_buffer_number = { background = 'background', foreground = 'light_blue'},
    lsp_status = {
        messages = { background = 'background', foreground = 'white' },
        diagnostics = {
            error = { background = 'background', foreground = 'red' },
            warning = { background = 'background', foreground = 'orange' },
            hint = { background = 'background', foreground = 'white' },
            info = { background = 'background', foreground = 'blue' }
        }
    }
}
vim.g.bubbly_inactive_color = vim.g.bubbly_colors
