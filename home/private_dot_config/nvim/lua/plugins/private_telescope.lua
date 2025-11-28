return {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
        { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
        { "<leader>fj", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File browser" },
    },
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

        require("telescope").load_extension("undo")
        require('telescope').load_extension('themes')
    end
}
