return {
    "laytan/cloak.nvim",
    opts = {
        enabled = true,
        cloak_character = "*",
        highlight_group = "Comment",
        patterns = {
            {
                file_pattern = {
                    ".env*",
                    "wrangler.toml",
                    ".dev.vars",
                },
                cloak_pattern = "=.+"
            },
        },
    },
    -- config = function()
    --     require("cloak").setup({
    --         enabled = true,
    --         cloak_character = "*",
    --         highlight_group = "Comment",
    --         patterns = {
    --             {
    --                 file_pattern = {
    --                     ".env*",
    --                     "wrangler.toml",
    --                     ".dev.vars",
    --                 },
    --                 cloak_pattern = "=.+"
    --             },
    --         },
    --     })
    -- end
}
