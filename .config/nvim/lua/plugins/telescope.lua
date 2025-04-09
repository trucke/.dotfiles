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
        'debugloop/telescope-undo.nvim',
    },
    opts = {
        defaults = {
            layout_config = { preview_width = 0.5 },
        },
        extensions = {
            ['ui-select'] = { require('telescope.themes').get_dropdown {} },
            undo = {},
        },
    },
    keys = {
        { '<leader>sh',  require('telescope.builtin').help_tags,    desc = 'Search Help' },
        { '<leader>sk',  require('telescope.builtin').keymaps,      desc = 'Search Keymaps' },
        { '<leader>sf',  require('telescope.builtin').find_files,   desc = 'Search Files' },
        { '<leader>sg',  require('telescope.builtin').git_files,    desc = 'Search Git files' },
        { '<leader>ss',  require('telescope.builtin').live_grep,    desc = 'Search String' },
        { '<leader>sd',  require('telescope.builtin').diagnostics,  desc = 'Search Diagnostics' },
        { '<leader>sc',  require('telescope.builtin').colorscheme,  desc = 'Search & Select color scheme' },
        { '<leader>sgb', require('telescope.builtin').git_branches, desc = 'Git Branches' },
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
            desc = 'Search Neovim files'
        },
        { '<leader>u', ':Telescope undo<CR>', desc = 'Search undo history' },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        pcall(require("telescope").load_extension("ui-select"))
        pcall(require("telescope").load_extension("fzf"))
        pcall(require("telescope").load_extension("undo"))
    end,
}
