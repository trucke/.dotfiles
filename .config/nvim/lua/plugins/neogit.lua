return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        graph_style = "unicode",
    },
    keys = {
        { "<leader>gs",  vim.cmd.Neogit },
        { "<leader>gb",  ":Telescope git_branches<CR>" },
        { "<leader>gds", vim.cmd.DiffviewOpen },
        { "<leader>gdc", vim.cmd.DiffviewClose },
    },
}
