return {
  'kuznetsss/delegate.nvim',
  config = true,
  -- dev = true,
  keys = {
    {
      '<F5>',
      function()
        require('delegate').repeatCommand()
      end,
    },
    {
      '<F6>',
      function()
        require('delegate').runCommand()
      end,
    },
    {
      '<F7>',
      function()
        require('delegate').stopCommand()
      end,
    },
    {
      '<F8>',
      function()
        require('delegate.outputs.qf_output'):toggle()
      end,
    },
  },
}
