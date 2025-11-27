return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        "debugloop/telescope-undo.nvim",
        "andrew-george/telescope-themes",
    },
    config = function()
        require("telescope").setup {
            defaults = {
                -- layout_config = {
                --     height = 15,
                -- },
                preview = {
                    hide_on_startup = true
                },
                mappings = {
                    i = {
                        ["<Tab>"] = require("telescope.actions").move_selection_next,
                        ["<S-Tab>"] = require("telescope.actions").move_selection_previous,
                        ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
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
                themes = {
                    ignore = {},
                },
            },
        }

        local builtin = require("telescope.builtin")
        local themes = require('telescope.themes')
        require("telescope").load_extension("undo")
        require('telescope').load_extension('themes')

        local opts = {
            layout_config = {
                height = 15,
            }
        }

        -- Keymaps
        vim.keymap.set("n", "<leader>fj", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", {silent=true})
        -- vim.keymap.set("n", "<leader>fj",
        --     function() require "telescope".extensions.file_browser.file_browser(themes.get_ivy(opts)) end, {})
        -- vim.keymap.set("n", "<leader>ff", function() builtin.find_files(themes.get_ivy(opts)) end, {})
        -- vim.keymap.set("n", "<leader>fs", function() builtin.live_grep(themes.get_ivy(opts)) end, {})
        -- vim.keymap.set("n", "<leader>fb", function() builtin.buffers(themes.get_ivy(opts)) end, {})
        -- vim.keymap.set('n', '<leader>fh', function() builtin.help_tags(themes.get_ivy(opts)) end, {})
        vim.keymap.set("n", "<leader>ff", function() builtin.find_files() end, {})
        vim.keymap.set("n", "<leader>fg", function() builtin.git_files() end, {})
        vim.keymap.set("n", "<leader>fs", function() builtin.live_grep() end, {})
        vim.keymap.set("n", "<leader>fb", function() builtin.buffers() end, {})
        vim.keymap.set('n', '<leader>fh', function() builtin.help_tags() end, {})
    end
}
