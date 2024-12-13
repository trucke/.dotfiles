return {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        { '<leader>of',
            function()
                return require('obsidian').util.gf_passthrough()
            end,
        },
        {
            '<leader>od',
            function()
                return require('obsidian').util.toggle_checkbox()
            end,
            desc = 'Obsidian - toggle checkbox'
        },
        {
            '<CR>',
            function()
                return require('obsidian').util.smart_action()
            end,
            desc = 'Obsidian - Smart Action (either follow link or toggle checkbox)'
        },
        { '<leader>on',  '<cmd>ObsidianNew<CR>',             desc = 'Obsidian - create new note' },
        { '<leader>ont', '<cmd>ObsidianNewFromTemplate<CR>', desc = 'Obsidian - create new note from template' },
        { '<leader>os',  '<cmd>ObsidianSearch<CR>',          desc = 'Obsidian - search vault' },
        { '<leader>ot',  '<cmd>ObsidianTemplate<CR>',        desc = 'Obsidian - insert template' },
        { '<leader>of',  '<cmd>ObsidianFollowLink<CR>',      desc = 'Obsidian - follow link including external links' },
        { '<leader>ow',  '<cmd>ZenMode | Twilight<CR>',      desc = 'Toggle ZenMode+Twilight' },
        { '<leader>op',  '<cmd>TogglePencil<CR>',            desc = 'Toggle pencil mode' },
    },
    opts = {
        ui = { enable = false },
        workspaces = {
            {
                name = 'mimirV2',
                path = '~/obsidian/mimirV2',
            },
        },
        notes_subdir = '0-Inbox',
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        mappings = {},
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

            local out = { id = note.id, aliases = note.aliases, tags = note.tags, }

            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do out[k] = v end
            end
            return out
        end,
        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
        -- URL it will be ignored but you can customize this behavior here.
        ---@param url string
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            vim.fn.jobstart({ "open", url }) -- Mac OS
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
            -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
            -- vim.ui.open(url) -- need Neovim 0.10.0+
        end,
        templates = { folder = 'Templates' },
        sort_by = 'path',
        attachments = {
            img_folder = 'Assets',
        },
    }
}
