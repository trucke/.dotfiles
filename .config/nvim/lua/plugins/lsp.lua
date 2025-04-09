-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
local servers = {
    bashls = {},
    gopls = {
        settings = {
            gopls = {
                analyses = { unusedparams = true },
                staticcheck = true,
                usePlaceholders = true,
                completeUnimported = true, -- this enables auto-import
            },
        },
    },
    elixirls = {},
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
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = { 'lazy.nvim', { path = 'luvit-meta/library', words = { 'vim%.uv' } } },
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', opts = {} },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim',       opts = {} },
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('dev-lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
                    map('<leader>f', vim.lsp.buf.format, '[F]ormat the current buffer')
                    map('K', vim.lsp.buf.hover, 'Hover Documentation')

                    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
                    map('grt', require('telescope.builtin').lsp_type_definitions, 'Goto Type Definition')

                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')

                    -- -- enable builtin auto-completion
                    -- local client = vim.lsp.get_client_by_id(event.data.client_id)
                    -- if client ~= nil and client:supports_method('textDocument/completion') then
                    --     vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
                    -- end
                end,
            })

            -- Diagnostic Config
            vim.diagnostic.config({
                virtual_lines = true,
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '󰅚 ',
                        [vim.diagnostic.severity.WARN] = '󰀪 ',
                        [vim.diagnostic.severity.INFO] = '󰋽 ',
                        [vim.diagnostic.severity.HINT] = '󰌶 ',
                    },
                } or {},
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },

            })

            local ensure_installed = vim.tbl_keys(servers or {})
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            vim.list_extend(ensure_installed, { 'stylua' })

            require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
            require('mason-lspconfig').setup {
                ensure_installed = {},
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    }
}
