return {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('render-markdown').setup({
            enabled = true,
            render_modes = { 'n' },
        })

        vim.keymap.set("n", "<leader>mt",
            function() require('render-markdown').toggle() end,
            { desc = "Switch between enabling & disabling markdown rendering" })
    end
}
