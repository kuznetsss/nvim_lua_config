return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = 'main',
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(event)
        local lang = vim.treesitter.language.get_lang(event.match)
            or event.match
        local buf = event.buf
        local ts = require 'nvim-treesitter'
        if not vim.tbl_contains(ts.get_available(), lang) then
          return
        end
        if vim.tbl_contains(ts.get_installed(), lang) then
          vim.treesitter.start(buf)
          return
        end
        vim.notify('Installing treesitter partser for ' .. lang)
        local i = 0
        local timer = vim.uv.new_timer()
        ts.install { lang }
        timer:start(
          0,
          1000,
          vim.schedule_wrap(function()
            i = i + 1
            if
                vim.list_contains(
                  ts.get_installed(),
                  vim.treesitter.language.get_lang(lang)
                )
            then
              timer:close()
              vim.treesitter.start(buf)
            end
            if i > 60 then
              timer:close()
              vim.notify("Parser installation took too long. Treesitter will not be enabled for "..lang..".", vim.log.levels.WARN)
            end
          end)
        )
      end,
    })
  end,
  -- event = { 'BufReadPre', 'BufNewFile' },
  -- config = function()
  --   require('nvim-treesitter.configs').setup {
  --     ensure_installed = 'all',
  --     highlight = { enable = true },
  --     indent = { enable = true },
  --     incremental_selection = {
  --       enable = true,
  --       keymaps = {
  --         init_selection = false, -- set to `false` to disable one of the mappings
  --         node_incremental = '+',
  --         scope_incremental = '_',
  --         node_decremental = '-',
  --       },
  --     },
  --   }
  -- end,
}
