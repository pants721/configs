-- super based off of jon gjengset's vim config https://github.com/jonhoo/configs

-- set leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

vim.opt.undofile = true

local tabwidth = 4
vim.opt.shiftwidth = tabwidth
vim.opt.softtabstop = tabwidth
vim.opt.tabstop = tabwidth
vim.opt.expandtab = true

-- vim.opt.spelllang = 'en_us'
-- vim.opt.spell = true

vim.opt.ignorecase = true

vim.opt.smartcase = true

vim.cmd "set rnu nu"

vim.opt.colorcolumn = '100'
vim.opt.signcolumn = 'yes'
vim.opt.guicursor = 'i:block'

-- disable auto comment on new line
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
    end,
})

vim.cmd "set termguicolors"
vim.opt.clipboard = "unnamedplus"

vim.opt.background = "dark"

-------------------------------------------------------------------------------
--
-- Hotkeys
--
-------------------------------------------------------------------------------

-- search buffers
vim.keymap.set('n', '<leader>;', '<cmd>Buffers<cr>')
-- quick-save
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
-- make missing : less annoying
vim.keymap.set('n', ';', ':')
-- jk as Esc
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'Jk', '<Esc>')
vim.keymap.set('i', 'jK', '<Esc>')
vim.keymap.set('i', 'JK', '<Esc>')
-- Jump to start and end of line using the home row keys
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')
-- Ctrl+h to stop searching
vim.keymap.set('v', '<C-h>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<C-h>', '<cmd>nohlsearch<cr>')
-- <leader><leader> toggles between buffers
vim.keymap.set('n', '<leader><leader>', '<c-^>')
-- let the left and right arrows be useful: they can switch buffers
vim.keymap.set('n', '<left>', ':bp<cr>')
vim.keymap.set('n', '<right>', ':bn<cr>')

vim.keymap.set('n', '<C-i>', '<C-a>')

-------------------------------------------------------------------------------
--
-- Plugins
--
-------------------------------------------------------------------------------

-- manager 'https://github.com/folke/lazy.nvim'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- actual plugins
require("lazy").setup({
    'rktjmp/lush.nvim',
    {
        url = "https://github.com/pants721/pants-modus.nvim",
        config = function()
            vim.cmd([[colorscheme modus_vivendi]])
        end
    },
    -- {
    --     "miikanissi/modus-themes.nvim",
    --     priority = 1000,
    --     config = function()
    --         vim.cmd([[colorscheme modus_vivendi]])
    --         vim.o.background = 'dark'
    --     end
    -- },
    {
        'nvim-lualine/lualine.nvim',
        priority = 1000,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'arkav/lualine-lsp-progress',
        },
        config = function()
            require('lualine').setup {
                sections = {
                    lualine_c = {
                        'filename',
                        'lsp_progress',
                    }
                },
                options = {
                    icons_enabled = false,
                    -- component_separators = { left = '', right = ''},
                    -- section_separators = { left = '', right = ''},
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    always_divide_middle = true,
                    globalstatus = true,
                },
            }
        end,
    },
    -- git
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = function()
            require('neogit').setup {
                kind = "replace",
            }
            vim.keymap.set('n', '<leader>gg', ":Neogit<cr>", {silent = true})
            vim.keymap.set('n', '<leader>gc', ":Neogit commit<cr>", {silent = true})
        end
    },
    -- LSP
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            'neovim/nvim-lspconfig',
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- Setup language servers.

            local lspconfig = require('lspconfig')
            lspconfig.ccls.setup {
                init_options = {
                    cache = {
                        directory = ".ccls-cache"
                    },
                },
            }
            require("mason").setup()
            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers {
                ['rust_analyzer'] = function() end,
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = require('cmp_nvim_lsp').default_capabilities()
                    }
                end,
            }
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    -- None of this semantics tokens business.
                    -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })
        end
    },
    -- LSP-based code-completion
    {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
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
                        cmp.select_next_item()
                            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                            -- they way you will only jump inside the snippet region
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                        end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
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
                    -- Accept currently selected item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    }, {
                        { name = 'path' },
                }),
                experimental = {
                    ghost_text = true,
                },
            })

            -- Enable completing paths in :
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                })
            })
        end
    },
    -- find some files
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("telescope").setup {
                defaults = {
                    layout_config = {
                        height = 15,
                    },
                    mappings = {
                        i = {
                            ["<Tab>"] = require("telescope.actions").move_selection_next,
                            ["<S-Tab>"] = require("telescope.actions").move_selection_previous,
                            ["<C-n>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_worse,
                            ["<C-p>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_better,
                        }
                    }
                },
                pickers = {
                    live_grep = {
                        mappings = {
                            i = { ["<c-space>"] = require("telescope.actions.generate").to_fuzzy_refine },
                        },
                    },
                    find_files = {
                        mappings = {
                            i = {
                                ["<c-space>"] = function(prompt_bufnr)
                                    require("telescope.actions.generate").refine(prompt_bufnr, {
                                        prompt_to_prefix = true,
                                        sorter = false,
                                    })
                                end,
                            },
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        path = "%:p:h",
                        cwd_to_path = true,
                        select_buffer = true,
                        hijack_netrw = true,
                    },
                },
            }
            require("telescope").load_extension "file_browser"
            local builtin = require("telescope.builtin")
            local themes = require('telescope.themes')
            local opts = {
                layout_config = {
                    height = 15,
                }
            }
            -- vim.keymap.set("n", "<leader>fj", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {silent=true})
            vim.keymap.set("n", "<leader>fj", function() require "telescope".extensions.file_browser.file_browser(themes.get_ivy(opts)) end, {})
            vim.keymap.set("n", "<leader>ff", function() builtin.find_files(themes.get_ivy(opts)) end, {})
            vim.keymap.set("n", "<leader>fs", function() builtin.live_grep(themes.get_ivy(opts)) end, {})
            vim.keymap.set("n", "<leader>fb", function() builtin.buffers(themes.get_ivy(opts)) end, {})
            vim.keymap.set('n', '<leader>fh', function() builtin.help_tags(themes.get_ivy(opts)) end, {})
        end
    },
    -- inline function signatures
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            -- Get signatures (and _only_ signatures) when in argument lists.
            require "lsp_signature".setup({
                doc_lines = 0,
                handler_opts = {
                    border = "none"
                },
            })
        end
    },
    -- language support
    -- Commentary
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-context',
            'windwp/nvim-ts-autotag',
        },
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { "c", "lua", "vim", "cpp", "python", "rust", "markdown", "toml", "go" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = {
                        function(lang, buf)
                            local max_filesize = 100 * 1024 -- 100 KB
                            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                            if ok and stats and stats.size > max_filesize then
                                return true
                            end
                        end,
                        -- "rust",
                        "lua",
                        "vimdoc",
                    },

                    additional_vim_regex_highlighting = {"markdown"},
                },
                indent = {
                    enable = true
                },
                refactor = {
                    smart_rename = {
                        enable = true,
                        keymaps = {
                            smart_rename = "grr",
                        },
                    },
                },
                autotag = {
                    enable = true,
                },
            }
            require 'treesitter-context'.setup {
                multiline_threshold = 5,
            }
        end
    },
    -- Autoclose ur brackets
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {
            map_c_h = true,
            map_c_w = true,
        },
    },
    -- Find files quickly
    {
        "ThePrimeagen/harpoon",
        config = function()
            vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
            vim.keymap.set("n", "<leader>h", require("harpoon.ui").toggle_quick_menu)

            vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end)
            vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end)
            vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end)
            vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end)
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        "lewis6991/gitsigns.nvim",
        config = true,
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'vidocqh/auto-indent.nvim',
        opts = {},
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = true,
    },
    {
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    },
    {
        "zbirenbaum/copilot.lua",
        opts = {
            suggestion  = {
                -- auto_trigger = true,
                keymap = {
                    accept_word = "<M-k>",
                    dismiss = "<M-j>",
                }
            },
        },
        cmd = "Copilot",
        event = "InsertEnter",
    },
    {
        "max397574/better-escape.nvim",
        opts = {
            mapping = {"jk"},
        }
    },
    { "stevearc/dressing.nvim", opts = {} },
    { 'brenoprata10/nvim-highlight-colors', config = true },
})

