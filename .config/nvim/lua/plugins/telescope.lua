return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function() return vim.fn.executable 'make' == 1 end,
        },
        'nvim-telescope/telescope-ui-select.nvim',
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        "debugloop/telescope-undo.nvim",
    },
    opts = {
        extensions = {
            ['ui-select'] = { require('telescope.themes').get_dropdown() },
            undo = {},
            fzf = {},
        },
    },
    keys = {
        { '<leader>sh', require('telescope.builtin').help_tags,   desc = 'Search Help' },
        { '<leader>sk', require('telescope.builtin').keymaps,     desc = 'Search Keymaps' },
        { '<leader>sf', require('telescope.builtin').find_files,  desc = 'Search Files' },
        { '<leader>sg', require('telescope.builtin').git_files,   desc = 'Search Git files' },
        { '<leader>sd', require('telescope.builtin').diagnostics, desc = 'Search Diagnostics' },
        { '<leader>sr', require('telescope.builtin').resume,      desc = 'Search Resume' },
        { '<leader>su', '<cmd>Telescope undo<cr>',                desc = 'Search undo tree' },
        {
            '<leader>/',
            function()
                require('telescope.builtin').current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    })
            end,
            desc = 'Fuzzi-Search current buffer'
        },
        {
            '<leader>sn',
            function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } end,
            desc = 'Fuzzi-Search current buffer'
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("undo")
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("fzf")
    end,
}
