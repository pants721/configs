-- Disable space in normal mode (leader key)
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })

-- Quick save
vim.keymap.set('n', '<leader>ww', '<cmd>w<cr>')

-- jk as Esc (case insensitive)
for _, key in ipairs({'jk', 'Jk', 'jK', 'JK'}) do
    vim.keymap.set('i', key, '<Esc>')
end

-- Jump to start and end of line using home row keys
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')

-- Clear search highlighting
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')
vim.keymap.set('v', '<C-h>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<C-h>', '<cmd>nohlsearch<cr>')

-- Buffer navigation
vim.keymap.set('n', '<leader><leader>', '<c-^>')
vim.keymap.set('n', '<left>', '<cmd>bp<cr>')
vim.keymap.set('n', '<right>', '<cmd>bn<cr>')

-- Increment/decrement numbers
vim.keymap.set('n', '<C-i>', '<C-a>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
