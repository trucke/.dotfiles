return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
        ensure_installed = { 'lua', 'luadoc', 'vim', 'vimdoc', 'bash', 'go', 'diff',
            'html', 'javascript', 'markdown', 'markdown_inline', "elixir", "heex" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        markdown = { enable = true },
    },
}
