return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                'lazy.nvim',
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            }
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
}
