-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
local servers = {
    bashls = {},
    gopls = {},
    ts_ls = {},
    tailwindcss = {},
    lexical = {},
    svelte = {},
    -- elixirls = {},
    lua_ls = {
        settings = {
            Lua = {
                completion = { callSnippet = 'Replace' },
                telemetry = { enable = false },
            },
        },
    },
}

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        { 'j-hui/fidget.nvim',       opts = {} },
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('dev-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('<leader>f', vim.lsp.buf.format, '[F]ormat the current buffer')
                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                map('gtd', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype [D]efinition')
                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                map('K', vim.lsp.buf.hover, 'Hover Documentation')
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            end,
        })


        local ensure_installed = vim.tbl_keys(servers or {})
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        vim.list_extend(ensure_installed, { 'stylua' })
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        require('mason').setup()
        require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
        require('mason-lspconfig').setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        })

        vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
    end,
}
