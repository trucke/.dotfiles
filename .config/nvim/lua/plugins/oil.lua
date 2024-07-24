return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup {
            columns = { "icon" },
            skip_confirm_for_simple_edits = true,
            float = {
                max_width = 120,
                max_height = 30,
            },
            view_options = { show_hidden = true },
        }

        -- Open parent directory in current window
        vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

        -- Open parent directory in floating window
        vim.keymap.set("n", "<leader><leader>", require("oil").toggle_float)
    end,
}
