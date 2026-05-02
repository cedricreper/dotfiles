vim.pack.add({
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/catppuccin/nvim",         name = 'catppuccin' },
})

require('gruvbox').setup({
    bold = false,
    italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = false,
    },
    contrast = 'hard', -- can be "hard", "soft" or empty string
})

require('catppuccin').setup({
    flavour = 'mocha',
    transparent_background = false,
})

vim.cmd.colorscheme('gruvbox')
