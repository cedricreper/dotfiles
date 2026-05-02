-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_user_command('Path', function()
  local filepath = vim.fn.expand '%:p'
  local filedir = vim.fn.expand '%:p:h'
  local git_dir = vim.fn.finddir('.git', filedir .. ';')

  local path
  if git_dir ~= '' then
    -- Found .git directory, get path relative to repo root
    local root = vim.fn.fnamemodify(git_dir, ':p:h:h')
    path = filepath:gsub('^' .. vim.pesc(root) .. '/', '')
  else
    -- Fallback to just filename if not in git repo
    path = vim.fn.expand '%:t'
  end

  vim.fn.setreg('+', path) -- copy to system clipboard
  print('Copied: ' .. path)
end, {})
