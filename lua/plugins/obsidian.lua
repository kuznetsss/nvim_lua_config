return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  -- lazy = true,
  -- ft = 'markdown',
  -- Load obsidian.nvim only for markdown files in the vault:
  -- event = {
  --   'BufReadPre ' .. vim.fn.expand('~') .. '/Documents/zk/**.md',
  --   'BufNewFile ' .. vim.fn.expand('~') .. '/Documents/zk/**.md',
  -- },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/zk/',
      },
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ['<leader> '] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
      ['<C-p>'] = {
        action = function()
          vim.cmd.ObsidianQuickSwitch()
        end,
        opts = { buffer = true },
      },
      ['<C-y>'] = {
        action = function()
          vim.cmd.ObsidianTags()
        end,
        opts = { buffer = true },
      },
    },
    ui = {
      bullets = { char = '', hl_group = 'ObsidianBullet' },
      hl_groups = {
        ObsidianTodo = { link = '@markup.list.unchecked' },
        ObsidianDone = { link = '@markup.list.checked' },
        ObsidianRigthArrow = { link = '@Constant' },
        ObsidianTilde = { bold = true, fg = '#ff5370' },
        ObsidianBullet = { link = '@markup.list', bold = true },
        ObsidianRefText = { link = '@markup.link' },
        ObsidianExtLinkIcon = { link = '@markup.link.label' },
        ObsidianTag = { link = '@markup.quote' },
        ObsidianBlockID = { italic = true, fg = '#89ddff' },
        ObsidianHighlightText = { bg = '#75662e' },
      },
    },
    picker = {
      mappings = {
        new = '<C-a>',
        insert_link = '<C-l>',
      },
    },
  },
}
