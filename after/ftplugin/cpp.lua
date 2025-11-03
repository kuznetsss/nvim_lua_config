vim.opt_local.commentstring = '// %s'
require('utils').nmap('gs', vim.cmd.LspClangdSwitchSourceHeader)
