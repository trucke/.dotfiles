return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
        sign = { enabled = false },
        code = {
            sign = false,
            left_pad = 2,
            language_pad = 2,
        },
        bullet = { left_pad = 2 },
        checkbox = {
            position = 'overlay',
            checked = { icon = '✔ ', scope_highlight = '@markup.strikethrough' },
            custom = {
                todo = { rendered = '◯ ' },
                delayed = { raw = '[~]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
            },
        },
        quote = { repeat_linebreak = true },
        win_options = {
            showbreak = { default = '', rendered = '  ' },
            breakindent = { default = false, rendered = true },
            breakindentopt = { default = '', rendered = '' },
        },
        pipe_table = {
            preset = 'round',
            min_width = 16,
        },
    },
}
