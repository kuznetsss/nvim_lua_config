local setup_luasnip = function()
  local luasnip = require 'luasnip'

  luasnip.config.set_config {
    region_check_events = 'InsertEnter',
    delete_check_events = 'InsertLeave',
  }

  local imap = require('utils').imap
  imap('<C-j>', function()
    return luasnip.expand_or_jumpable() and luasnip.expand_or_jump()
  end)
  imap('<C-k>', function()
    return luasnip.jumpable(-1) and luasnip.jump(-1)
  end)
  imap('<C-l>', function()
    return luasnip.choice_active() and luasnip.change_choice(1)
  end)
  require'snippets.lua'
end

return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  config = setup_luasnip,
}
