return {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {
        ui = { enable = false },
        workspaces = {
            {
                name = 'Mimir',
                path = '~/obsidian/Mimir',
            },
        },
        notes_subdir = '0-Inbox',
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        mappings = {
            ['<leader>of'] = {
                action = function() return require('obsidian').util.gf_passthrough() end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            ['<leader>od'] = {
                action = function() return require('obsidian').util.toggle_checkbox() end,
                opts = { buffer = true },
            },
            ['<leader>on'] = { action = "<cmd>ObsidianNew<CR>", opts = { buffer = true } },
            ['<leader>ont'] = { action = "<cmd>ObsidianNewFromTemplate<CR>", opts = { buffer = true } },
            ['<leader>os'] = { action = "<cmd>ObsidianSearch<CR>", opts = { buffer = true } },
            ['<leader>ow'] = { action = "<cmd>ZenMode | Twilight<CR>", opts = { buffer = true } },
            ['<leader>op'] = { action = "<cmd>TogglePencil<CR>", opts = { buffer = true } },
        },
        new_notes_location = 'notes_subdir',
        note_id_func = function(title)
            assert(title ~= nil, 'No title given')
            local suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            return suffix
        end,
        wiki_link_func = 'prepend_note_id',
        note_frontmatter_func = function(note)
            if note.title then
                note:add_alias(note.title)
            end

            local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = '', project = '' }

            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do out[k] = v end
            end
            return out
        end,
        templates = { folder = 'Templates' },
        sort_by = 'path',
        attachments = {
            img_folder = 'Assets',
        },
    }
}
