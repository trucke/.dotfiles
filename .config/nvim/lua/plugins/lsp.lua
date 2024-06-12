-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    local t = require('telescope.builtin')
    vim.keymap.set('n', 'gd', t.lsp_definitions, { desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gr', t.lsp_references, { desc = '[G]oto [R]ferences' })
    vim.keymap.set('n', 'gI', t.lsp_implementations, { desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', '<leader>ws', t.lsp_dynamic_workspace_symbols, { desc = '[W]orkplace [S]ymbols' })
    vim.keymap.set('n', '<leader>td', t.lsp_type_definitions, { desc = '[T]ype [D]efinition' })

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = 'Open diagnostics' })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { desc = 'Goto next diagnostics' })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = 'Goto prev diagnostics' })
end

local servers = {
    gopls = {},
    rust_analyzer = {},
    tsserver = {},
    pyright = {},

    lua_ls = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false },
            library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
            },
            telemetry = { enable = false },
            diagnostics = { globals = { 'vim' } },
            completion = {
                callSnippet = 'Replace'
            }
        },
    },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'j-hui/fidget.nvim',
        "folke/neodev.nvim",
    },
    config = function()
        require('fidget').setup({})
        require('neodev').setup({})
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end,
            },
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
