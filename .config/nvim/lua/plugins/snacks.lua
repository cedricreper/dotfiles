vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
})

require('snacks').setup({
    indent = {
        scope = { enabled = true },
    },
})
