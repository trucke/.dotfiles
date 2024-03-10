-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>ex', vim.cmd.Ex, { desc = 'Open netrw' })
vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format()
    vim.print('file formatted')
    vim.defer_fn(function() vim.print('') end, 500)
end, { desc = '[F]ormat the current buffer' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move current line up' })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move current line down' })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
