require('settings')
require('colors')
local bootstrapped = require('plugins')
if bootstrapped then
    print("bootstrapped mode: not full config have been loaded")
    return
end
require('run_command')
require('mappings')
require('autocmd')
require('statusline')
