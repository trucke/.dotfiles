return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        default_file_explorer = true,
        columns = { "icon" },
        skip_confirm_for_simple_edits = true,
        float = {
            max_width = 80,
            max_height = 25,
        },
        view_options = { show_hidden = true },
        win_options = {
            signcolumn = "yes",
        },
    },
    config = function(_, opts)
        require("oil").setup(opts)
        vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        vim.keymap.set("n", "<leader><leader>", require("oil").toggle_float)
    end,
}
