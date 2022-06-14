local bootstrapped = require 'plugins.install'
if bootstrapped then
    return true
end
require 'plugins.lsp'
require 'plugins.mappings'
require 'plugins.dap'
return false
