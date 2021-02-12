local set_option = require'common'.set_option
-- Support true color
set_option('o', 'termguicolors', true)

set_option('o', 'background', 'dark')
vim.cmd('syntax on')

vim.cmd('colorscheme wombat256mod')

-- Color right part in different color
vim.cmd('highlight ColorColumn guibg=#313233')

local signcolumn_color = '#282828'
-- Adjust background of column left of line numbers
vim.cmd('highlight SignColumn guibg=' .. signcolumn_color)

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
