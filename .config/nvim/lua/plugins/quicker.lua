return {
    'stevearc/quicker.nvim',
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
    config = function()
        require("quicker").setup {}
        vim.keymap.set("n", "<leader>-", function() require("quicker").toggle() end, { desc = "Open parent directory" })
    end
}
