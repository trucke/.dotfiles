return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    keys = {
        {
            '<leader>-',
            function() require('oil').open(nil, { preview = {} }) end,
            desc = 'Open file explorer'
        },
        { '<leader><leader>', function() require('oil').toggle_float() end, desc = 'Open file explorer - floating window' },
    },
    opts = {
        default_file_explorer = true,
        columns = { 'icon' },
        skip_confirm_for_simple_edits = true,
        float = {
            max_width = 90,
            max_height = 30,
        },
        view_options = { show_hidden = true },
        win_options = {
            signcolumn = 'yes',
        },
        preview_win = {
            win_options = { wrap = false }
        },
    },
}
