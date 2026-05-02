vim.pack.add({
    { src = "https://github.com/echasnovski/mini.nvim" },
})

-- Text editing
require('mini.ai').setup()
require('mini.operators').setup()
require('mini.surround').setup({
    mappings = {
        add = 'ya',            -- Add surrounding in Normal and Visual modes
        delete = 'yd',         -- Delete surrounding
        find = 'yf',           -- Find surrounding (to the right)
        find_left = 'yF',      -- Find surrounding (to the left)
        highlight = 'yh',      -- Highlight surrounding
        replace = 'yr',        -- Replace surrounding
        update_n_lines = 'yn', -- Update `n_lines`
    },
})

-- Workflow
require('mini.bracketed').setup()
local hipatterns = require('mini.hipatterns')
hipatterns.setup({
    highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

-- Appearance
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()
