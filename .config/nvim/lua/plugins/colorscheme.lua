return {
    'folke/tokyonight.nvim',
    lazy = false,
    -- 'catppuccin/nvim',
    -- name = 'catppuccin',
    priority = 1000,
    init = function()
        -- vim.cmd.colorscheme 'catppuccin-mocha'
        vim.cmd.colorscheme 'tokyonight-night'
    end,
}
