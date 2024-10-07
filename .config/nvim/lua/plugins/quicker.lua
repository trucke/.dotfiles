return {
    'stevearc/quicker.nvim',
    event = "FileType qf",
    opts = {},
    keys = {
        { "<leader>qf", function() require("quicker").toggle() end, desc = "Toggle quickfix" },
    },
}
