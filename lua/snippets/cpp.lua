require('luasnip.session.snippet_collection').clear_snippets 'cpp'

local ls = require 'luasnip'

local s = ls.snippet
local i = ls.insert_node

local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('cpp', {
  s(
    'ns',
    fmt(
      [[
namespace <name> {
} // namespace <name>
]],
      {
        name = i(1, 'name'),
      },
      { repeat_duplicates = true, delimiters = '<>' }
    )
  ),
})
