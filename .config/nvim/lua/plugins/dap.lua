vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
})

local dap = require('dap')
local ui = require('dapui')
local dap_virtual_text = require('nvim-dap-virtual-text')

-- Dap Virtual Text
dap_virtual_text.setup()

-- Adapters
-- Install the cppdbg adapter manually (no mason). Easiest path:
--   1. Download the latest "cpptools-osx-arm64.vsix" (or x64) from
--      https://github.com/microsoft/vscode-cpptools/releases
--   2. Unzip it (it's just a zip) and place the `extension/` folder at
--      ~/.local/share/nvim/dap/cpptools/
--   3. chmod +x ~/.local/share/nvim/dap/cpptools/debugAdapters/bin/OpenDebugAD7
local cpptools_path = vim.fn.stdpath('data') ..
    '/dap/cpptools/extension/debugAdapters/bin/OpenDebugAD7'

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = cpptools_path,
}

-- Install debugpy manually (no mason):
--   python3 -m venv ~/.local/share/nvim/dap/debugpy
--   ~/.local/share/nvim/dap/debugpy/bin/pip install debugpy
local debugpy_python = vim.fn.stdpath('data') .. '/dap/debugpy/bin/python'

dap.adapters.python = {
    type = 'executable',
    command = debugpy_python,
    args = { '-m', 'debugpy.adapter' },
}

-- Configurations
dap.configurations.c = {
    {
        name = 'Launch file',
        type = 'cppdbg',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = false,
        MIMode = 'lldb',
    },
    {
        name = 'Attach to lldbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'lldb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/lldb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}
dap.configurations.cpp = dap.configurations.c

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            else
                return '/usr/local/bin/python3'
            end
        end,
    },
}

-- Dap UI
ui.setup()

vim.fn.sign_define('DapBreakpoint', { text = '🐞' })

dap.listeners.before.attach.dapui_config = function() ui.open() end
dap.listeners.before.launch.dapui_config = function() ui.open() end
dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
dap.listeners.before.event_exited.dapui_config = function() ui.close() end

-- Keymaps
local map = function(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { desc = desc, nowait = true, remap = false })
end

map('<leader>dt', function() dap.toggle_breakpoint() end, '[D]ebugger [T]oggle Breakpoint')
map('<leader>dc', function() dap.continue() end, '[D]ebugger [C]ontinue')
map('<leader>di', function() dap.step_into() end, '[D]ebugger Step [I]nto')
map('<leader>do', function() dap.step_over() end, '[D]ebugger Step [O]ver')
map('<leader>du', function() dap.step_out() end, '[D]ebugger Step O[u]t')
map('<leader>dr', function() dap.repl.open() end, '[D]ebugger Open [R]EPL')
map('<leader>dl', function() dap.run_last() end, '[D]ebugger Run [L]ast')
map('<leader>dq', function()
    dap.terminate()
    ui.close()
    dap_virtual_text.toggle()
end, '[D]ebugger [Q]uit/Terminate')
map('<leader>db', function() dap.list_breakpoints() end, '[D]ebugger List [B]reakpoints')
map('<leader>de', function() dap.set_exception_breakpoints({ 'all' }) end, '[D]ebugger Set [E]xception Breakpoints')
