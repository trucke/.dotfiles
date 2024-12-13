return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        notifier = { enabled = true, timeout = 3000 },
        quickfile = { enabled = true },
        input = { enabled = true },
        zen = { enabled = true },
    },
    keys = {
        { "<leader>z",  function() Snacks.zen() end,                   desc = "Toggle Zen Mode" },
        { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    }
}
