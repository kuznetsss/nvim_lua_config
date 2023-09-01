local lsp_signs = require('utils').signs
local format = require('statusline.common').format

local M = {}

local get_diagnostic_counts = function()
  local diagnostics = {
    warnings = {
      severity = vim.diagnostic.severity.WARN,
      count = 0,
    },
    errors = {
      severity = vim.diagnostic.severity.ERROR,
      count = 0,
    },
    info = {
      severity = vim.diagnostic.severity.INFO,
      count = 0,
    },
    hints = {
      severity = vim.diagnostic.severity.HINT,
      count = 0,
    },
  }
  for _, d in pairs(diagnostics) do
    d.count = #vim.diagnostic.get(0, { severity = d.severity })
  end
  return diagnostics
end

M.get_diagnostics = function()
  local diagnostics = get_diagnostic_counts()
  local result = ''
  if diagnostics.warnings.count ~= 0 then
    result = result
      .. format(
        lsp_signs.Warn .. diagnostics.warnings.count .. ' ',
        'FixedLineLspWarning'
      )
  else
    result = result .. '   '
  end
  if diagnostics.errors.count ~= 0 then
    result = result
      .. format(
        lsp_signs.Error .. diagnostics.errors.count .. ' ',
        'FixedLineLspError'
      )
  else
    result = result .. '   '
  end
  if diagnostics.info.count ~= 0 then
    result = result
      .. format(
        lsp_signs.Info .. diagnostics.info.count .. ' ',
        'FixedLineLspInfo'
      )
  else
    result = result .. '   '
  end
  if diagnostics.hints.count ~= 0 then
    result = result
      .. format(
        lsp_signs.Hint .. diagnostics.hints.count .. ' ',
        'FixedLineLspHint'
      )
  else
    result = result .. '   '
  end

  return result
end

return M
