-- Blink.cmp configuration (active)
return {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',
    opts = {
        keymap = {
            preset = 'default',
            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        completion = {
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                }
            },
        },
        signature = { enabled = true }
    },
}

-- OLD nvim-cmp configuration (commented out - uncomment to revert)
--[[
return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        'neovim/nvim-lspconfig',
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind.nvim",
        "windwp/nvim-autopairs",
    },
    config = function()
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[Latex]",
                    })
                }),
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            window = {
                completion = {
                    border = nil,
                    scrollbar = '',
                },
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
            }, {
                { name = 'path' },
            }),
            experimental = {
                ghost_text = false,
            },
        })

        -- Enable completing paths in :
        cmp.setup.cmdline(':', {
            sources = cmp.config.sources({
                { name = 'path' }
            })
        })
    end
}
--]]
