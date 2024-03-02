return {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
        require('catppuccin').setup({
            flavour = 'macchiato',
            transparent_background = false,
            term_colors = true,
            styles = {
                comments = {},
                conditionals = {},
            },
        })
        vim.cmd.colorscheme 'catppuccin'
    end
}
