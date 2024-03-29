local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = require("telescope.config").values.file_previewer({}),
        sorter = require("telescope.config").values.generic_sorter({}),
    }):find()
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require('harpoon')
        harpoon.setup({})

        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():append()
        end, { desc = '[h]arpoon [a]ppend current file' })
        vim.keymap.set("n", "<C-t>", function()
            toggle_telescope(harpoon:list())
        end, { desc = 'Open harpoon' })
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = 'Open harpoon' })
        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-P>", function() harpoon:list():prev() end,
            { desc = 'Go to [P]revious buffer stored within Harpoon lists' })
        vim.keymap.set("n", "<C-N>", function() harpoon:list():next() end,
            { desc = 'Go to [N]ext buffer stored within Harpoon lists' })
    end
}
