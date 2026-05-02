vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
})

require('conform').setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = false, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
        else
            return {
                timeout_ms = 500,
                lsp_format = 'fallback',
            }
        end
    end,
    formatters_by_ft = {
        c = { 'clang-format' },
        lua = { 'stylua' },
        zig = { 'zigfmt' },
        rust = { 'rustfmt' },
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
    },
})

vim.keymap.set('', '<leader>m', function()
    require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'For[m]at buffer' })
