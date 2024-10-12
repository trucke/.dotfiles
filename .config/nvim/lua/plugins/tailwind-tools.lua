return {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-telescope/telescope.nvim',
        'neovim/nvim-lspconfig',
    },
    keys = {
        { '<space>tt', '<cmd>TailwindConcealToggle<CR>', desc = 'Toggle Tailwind concealing' },
        { '<space>tc', '<cmd>TailwindColorToggle<CR>',   desc = 'Toggle Tailwind color hints' },
        { '<space>ts', '<cmd>TailwindSort<CR>',          desc = 'Sort all clases in the current buffer' },
    },
    opts = {}
}
