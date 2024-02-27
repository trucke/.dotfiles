return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require('neogit').setup({})
        vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit)
    end
}
