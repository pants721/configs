return {
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
    },
    {
        "mason-org/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = "mason-org/mason.nvim",
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            -- Setup Mason
            require('mason').setup()
            require('mason-lspconfig').setup({
                automatic_installation = true,
            })

            -- Get blink.cmp capabilities
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Setup common servers using native vim.lsp.config
            local servers = { 'lua_ls', 'pyright', 'rust_analyzer', 'ts_ls', 'clangd', 'gopls', 'hls' }

            for _, server in ipairs(servers) do
                vim.lsp.config[server] = {
                    capabilities = capabilities,
                }
            end

            vim.lsp.config['lua_ls'] = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.list_extend(
                                vim.api.nvim_get_runtime_file("", true),
                                { "~/dev/orca.nvim/lua" }  -- <- add your dev plugin here
                            ),
                        },
                        completion = {
                            callSnippet = 'Replace',
                        },
                    },
                },
            }

            -- LSP attach autocommand for keymaps
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)

                    -- Disable semantic tokens
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client then
                        client.server_capabilities.semanticTokensProvider = nil
                    end
                end,
            })
        end
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            settings = {
                Lua = {
                    diagnostics = {
                        ignoredFiles = 'Enable',
                        groupFileStatus = {
                            ambiguity = 'Any',
                            await = 'Any',
                            duplicate = 'Any',
                            global = 'Any',
                            luadoc = 'Any',
                            redefined = 'Any',
                            strict = 'Any',
                            ['type-check'] = 'Any',
                            unbalanced = 'Any',
                            unused = 'Any',
                        },
                    },
                },
            },
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
