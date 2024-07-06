return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require('neogit').setup({
            graph_style = "unicode",
        })
        vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit)
        vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>")
        vim.keymap.set("n", "<leader>gds", vim.cmd.DiffviewOpen)
        vim.keymap.set("n", "<leader>gdc", vim.cmd.DiffviewClose)
    end
}
