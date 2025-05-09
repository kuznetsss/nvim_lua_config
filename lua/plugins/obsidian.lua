return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'saghen/blink.cmp',
  },
  cmd = { 'Obsidian' },
  keys = {
    { '<leader>zk', '<cmd>Obsidian search<cr>', desc = 'Search in Obsidian' },
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/zk/',
      },
    },
    daily_notes = {
      folder = '0-Daily',
    },
    completion = {
      nvim_cmp = false,
      blink = true,
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
      ['<leader>ch'] = {
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
          vim.cmd.Obsidian 'quick_switch'
        end,
        opts = { buffer = true },
      },
      ['<C-y>'] = {
        action = function()
          vim.cmd.Obsidian 'tags'
        end,
        opts = { buffer = true },
      },
    },
    ui = {
      enable = false,
      -- bullets = { char = '', hl_group = 'ObsidianBullet' },
      -- hl_groups = {
      --   ObsidianTodo = { link = '@markup.list.unchecked' },
      --   ObsidianDone = { link = '@markup.list.checked' },
      --   ObsidianRigthArrow = { link = '@Constant' },
      --   ObsidianTilde = { bold = true, fg = '#ff5370' },
      --   ObsidianBullet = { link = '@markup.list', bold = true },
      --   ObsidianRefText = { link = '@markup.link' },
      --   ObsidianExtLinkIcon = { link = '@markup.link.label' },
      --   ObsidianTag = { link = '@markup.quote' },
      --   ObsidianBlockID = { italic = true, fg = '#89ddff' },
      --   ObsidianHighlightText = { bg = '#75662e' },
      -- },
    },
    picker = {
      name = 'snacks.pick',
      mappings = {
        new = '<C-a>',
        insert_link = '<C-l>',
      },
    },
  },
}
