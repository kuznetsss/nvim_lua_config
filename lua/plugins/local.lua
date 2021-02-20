local patch = function(default)
    default['lsp_cmd']['clangd'] = {
        "clangd",
        "--background-index",
        "-j=1",
        "--header-insertion=never"
    }
    return default
end
return patch
