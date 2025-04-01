return {
    {
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
                style = 'normal',
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
            heading = {
                position = 'inline',
                border = true,
            },
            quote = { repeat_linebreak = true },
            win_options = {
                showbreak = { default = '', rendered = '  ' },
                breakindent = { default = false, rendered = true },
                breakindentopt = { default = '', rendered = '' },
            },
            pipe_table = {
                preset = 'round',
                min_width = 25,
            },
            latex = { enabled = false },
        },
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        opts = {
            theme = 'dark', -- 'dark' or 'light'
            -- app = 'webview', -- 'webview', 'browser', string or a table of strings
        },
        keys = {
            { '<leader>mp',  function() require('peek').open() end,  desc = 'Open Markdown Preview' },
            { '<leader>mpc', function() require('peek').close() end, desc = 'Close Markdown Preview' },
        },
    },
}
