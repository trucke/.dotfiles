return {
    "folke/noice.nvim",
    lazy = false,
    priority = 1005,
    dependencies = {
        "MunifTanjim/nui.nvim",
        'rcarriga/nvim-notify'
    },
    opts = {
        cmdline = { view = 'cmdline' },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
    },
    keys = {
        { "<leader>nd", function() require('noice').cmd('dismiss') end,   desc = "Noice Dismiss" },
        { "<leader>nh", function() require('noice').cmd('telescope') end, desc = "Noice History" },
        { "<leader>ne", function() require('noice').cmd('errors') end,    desc = "Noice Errors" },
    },
}
