---@type vim.lsp.Config
return {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = {
        'compile_commands.json',
        'compile_flags.txt',
        'CMakeLists.txt',
        'CMakePresets.json',
        'Makefile',
        'meson.build',
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        '.git',
    },
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { 'utf-8', 'utf-16' },
    },
    settings = {},
}
