-- Disable auto comment symbols insert
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = { '*' },
    command = 'setlocal formatoptions-=cro',
})

-- Terminal setup
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
    pattern = { '*' },
    callback = function()
        vim.cmd 'startinsert'
        vim.opt_local.buflisted = false
        vim.opt_local.bufhidden = 'hide'
    end,
})

-- SignatureHelp
vim.api.nvim_create_autocmd({ 'CursorHoldI' }, {
    pattern = { '*' },
    callback = function()
        require('lspsaga.signaturehelp').signature_help()
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'lua,c,cpp,python,bash' },
    callback = function()
        vim.opt_local.colorcolumn = '81,82,83'
    end,
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = '*/lua/plugins/install.lua',
    callback = function()
        package.loaded['plugins.install'] = nil
        require 'plugins.install'
        require('packer').compile()
        print 'Recompiled'
    end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
    pattern = '*',
    callback = function()
        require('common').save_file()
    end,
})
