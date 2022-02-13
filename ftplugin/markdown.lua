if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
    local map = require('common').map

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
  -- Alternative for backlinks using pure LSP and showing the source context.
  --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- Open notes linked by the current buffer.
  map("n", "<leader>zl", "<Cmd>ZkLinks<CR>")

  -- Open the code actions for a visual selection.
  map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>")
end
vim.w.spell = true
vim.b.spelllang = 'en,ru'
