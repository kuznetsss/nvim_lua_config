if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
    local current_buffer = vim.api.nvim_get_current_buf()
    local map = function(...)
        require('common').local_map(current_buffer, ...)
    end

    -- Open the link under the caret.
    map("n", "<CR>", "<cmd>lua vim.lsp.buf.definition()<CR>")

    -- Create a new note after asking for its title.
    -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
    map("n", "<leader>zn", "<Cmd>ZkNew<CR>")
    -- Create a new note in the same directory as the current buffer, using the current selection for title.
    map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection<CR>")
    -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
    map("v", "<leader>znc",
      ":'<,'>ZkNewFromContentSelection {title = vim.fn.input('Title: ') }<CR>")

    -- Open notes linking to the current buffer.
    map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>")

    -- Open notes linked by the current buffer.
    map("n", "<leader>zl", "<Cmd>ZkLinks<CR>")

    -- Open the code actions for a visual selection.
    map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>")

    map('n', '<C-p>', '<cmd>ZkNotes<CR>')
    map('n', '<C-y>', '<cmd>ZkTags<CR>')
end
vim.wo.spell = true
vim.bo.spelllang = 'en,ru'
