return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("trouble").setup({
            icons = true,
        })

        vim.keymap.set("n", "<leader>tt", function()
            require("trouble").toggle()
        end, { desc = '[T]oggle [T]rouble' })

        vim.keymap.set("n", "[t", function()
            require("trouble").next({ skip_groups = true, jump = true });
        end)

        vim.keymap.set("n", "]t", function()
            require("trouble").previous({ skip_groups = true, jump = true });
        end)
    end
}
