return {
    --'folke/tokyonight.nvim',
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
        vim.cmd.colorscheme 'catppuccin-mocha'
        -- You can configure highlights by doing something like:
        -- vim.cmd.hi 'Comment gui=none'
    end,
}
