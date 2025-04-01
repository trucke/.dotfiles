return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            ---@diagnostic disable-next-line missing-fields
            require('kanagawa').setup {
                commentStyle = { italic = false },
            }
            vim.cmd.colorscheme 'kanagawa-wave'
        end,
    },
    { 'catppuccin/nvim',       name = 'catppuccin', event = 'VeryLazy' },
    { 'folke/tokyonight.nvim', lazy = false,        priority = 1000, },
}
