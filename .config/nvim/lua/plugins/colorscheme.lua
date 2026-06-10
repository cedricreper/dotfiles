vim.pack.add({
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/catppuccin/nvim",             name = 'catppuccin' },
    { src = "https://github.com/miikanissi/modus-themes.nvim" },
})

require('gruvbox').setup({
    bold = true,
    -- italic = {
    --     strings = false,
    --     emphasis = false,
    --     comments = true
    --     operators = false,
    --     folds = false,
    -- },
    --    contrast = 'hard',
})

require('catppuccin').setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = {    -- :h background
        light = "latte",
        dark = "mocha",
    },
})

require('modus-themes').setup({
    style = 'auto',
})

vim.cmd.colorscheme('modus')
