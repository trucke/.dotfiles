return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'Avante' },
    keys = {
        { '<leader>rmt', '<cmd>RenderMarkdown toggle<CR>', desc = 'Toggle markdown renderer' },
    },
    opts = {
        file_types = { 'markdown', 'Avante' },
        sign = { enabled = false },
        code = {
            sign = false,
            left_pad = 2,
            language_pad = 2,
        },
        checkbox = {
            position = 'inline',
            checked = { icon = '✔ ', highlight = 'RenderMarkdownChecked', scope_highlight = nil },
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
        latex = { enabled = false },
    },
}
