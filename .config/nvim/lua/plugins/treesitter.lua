vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
})

local parsers = {
    'bash',
    'c',
    'css',
    'diff',
    'html',
    'htmldjango',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'rust',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'zig',
}

-- Install missing parsers (async). Also re-installs whenever the plugin is updated.
local function install_parsers()
    require('nvim-treesitter').install(parsers)
end

vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('user-treesitter-update', { clear = true }),
    callback = function(event)
        if event.data and event.data.spec and event.data.spec.name == 'nvim-treesitter' then
            vim.schedule(install_parsers)
        end
    end,
})

-- Make sure parsers are installed at least once after first add.
pcall(install_parsers)

-- Enable highlighting and indent for the configured filetypes via FileType autocmd.
local filetypes = {
    'bash',
    'c',
    'css',
    'diff',
    'help', -- uses the `vimdoc` parser
    'html',
    'htmldjango',
    'javascript',
    'javascriptreact',
    'json',
    'less', -- uses the `css` parser (registered below)
    'lua',
    'markdown',
    'python',
    'query',
    'rust',
    'typescript',
    'typescriptreact',
    'vim',
    'zig',
}

-- Use the `css` parser for `.less` files (no dedicated less parser).
vim.treesitter.language.register('css', 'less')

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('user-treesitter-start', { clear = true }),
    pattern = filetypes,
    callback = function(args)
        -- Highlighting
        pcall(vim.treesitter.start, args.buf)
        -- Indent (opt-in per buffer using treesitter-provided indentexpr)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
