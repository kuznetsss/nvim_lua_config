local set_option = require'common'.set_option
-- Support true color
set_option('o', 'termguicolors', true)

set_option('o', 'background', 'dark')
vim.cmd('syntax on')

vim.cmd('colorscheme wombat256mod')
-- Color right part in different color
vim.cmd('highlight ColorColumn guibg=#313233')

-- Adjust background of column left of line numbers
vim.cmd('highlight SignColumn guibg=#282828')

-- Adjust LspSaga colors
vim.api.nvim_exec([[
    highlight DiagnosticError guifg='#9f0000' guibg='#000000' gui='bold'
    highlight DiagnosticWarning guifg='#ff8900' guibg='#000000' gui='bold'
    highlight DiagnosticInformation guifg='#000080' guibg='#000000' gui='bold'
    highlight DiagnosticHint guifg='#aafa00' guibg='#000000' gui='bold'
]], false)
