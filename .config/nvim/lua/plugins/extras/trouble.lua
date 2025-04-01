return {
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            { "<leader>td", ":Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
            { "<leader>tq", ":Trouble qflist toggle<CR>",      desc = "Quickfix List (Trouble)", },
        },
    },
    {
        "folke/todo-comments.nvim",
        event = 'VimEnter',
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
            highlight = { keyword = "fg" },
        },
        keys = {
            { "<leader>ts", ":TodoTelescope<CR>", desc = "Show TODOs in Telescope" },
            { "<leader>tt", ":TodoTrouble<CR>",   desc = "Show TODOs in Trouble" },
        },
    }
}
