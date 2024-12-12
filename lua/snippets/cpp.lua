require('luasnip.session.snippet_collection').clear_snippets 'cpp'

local ls = require 'luasnip'

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node

local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('cpp', {
  s(
    { trig = 'ns (.*)', regTrig = true },
    fmt(
      [[
namespace <name> {

<code>

} // namespace <name>
]],
      {
        name = f(function(_, snip)
          return snip.captures[1]
        end),
        code = i(0),
      },
      { repeat_duplicates = true, delimiters = '<>' }
    )
  ),
})
