return {
  'hiphish/rainbow-delimiters.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    vim.g.rainbow_delimiters = {
      highlight = {
        'RainbowDelimiterGreen',
        'RainbowDelimiterYellow',
        'RainbowDelimiterOrange',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
        'RainbowDelimiterBlue',
        'RainbowDelimiterRed',
      },
    }
  end,
}
