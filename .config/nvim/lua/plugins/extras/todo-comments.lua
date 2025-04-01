return {
    "folke/todo-comments.nvim",
    event = 'VimEnter',
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = false,
        highlight = { keyword = "fg" },
    },
    keys = {
        { "<leader>st", "<cmd>TodoTelescope<cr>",                         desc = "Todo" },
        { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
}
