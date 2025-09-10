local nmap = require('utils').nmap

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  enabled = false,
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
    legacy_commands = false,
    callbacks = {
      enter_note = function(client, note)
        nmap('gf', function()
          return require('obsidian').util.gf_passthrough()
        end, { noremap = false, expr = true, buffer = true })

        nmap('<leader>ch', function()
          return require('obsidian').util.toggle_checkbox()
        end, { buffer = true })

        nmap('<cr>', function()
          return require('obsidian').util.smart_action()
        end, { buffer = true, expr = true })

        nmap('<C-p>', function()
          vim.cmd.Obsidian 'search'
        end, { buffer = true })

        nmap('<C-y>', function()
          vim.cmd.Obsidian 'tags'
        end, { buffer = true })
      end,
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
