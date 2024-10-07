return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            backdrop = 0.95,
            width = 120,
            height = 1,
            options = {
                signcolumn = "no",
                number = false,
                relativenumber = false,
            },
        },
        plugins = {
            options = {
                enabled = true,
                ruler = true,
                showcmd = false,
                laststatus = 0,
            },
            twilight = { enabled = false },
            tmux = { enabled = true },
            kitty = {
                enabled = true,
                font = "+20",
            },
        },
    },
}
