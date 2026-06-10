---@type vim.lsp.Config
return {
    cmd = { 'asm-lsp' },
    filetypes = {
        "asm", "s", "S"
    },
    root_markers = {
        '.asm-lsp.toml',  -- asm-lsp's own config file
        '.git',           -- most common fallback
        'Makefile',       -- assembly projects almost always use make
        'CMakeLists.txt', -- if part of a C/asm cmake project
    },
}
