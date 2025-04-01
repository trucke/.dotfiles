return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
        ensure_installed = { 'bash', 'diff', 'html', 'json', 'lua', 'luadoc', 'markdown', 'markdown_inline',
            'query', 'toml', 'vim', 'vimdoc', 'yaml' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        markdown = { enable = true },
    },
}
