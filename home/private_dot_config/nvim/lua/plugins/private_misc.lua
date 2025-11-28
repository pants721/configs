return {
    -- Simple plugins with minimal config
    {
        "pants721/orca.nvim",
        config = function ()
            local orca = require("orca")
            orca.setup()
            vim.keymap.set("n", "<leader>o", function () orca:toggle_orca() end)
        end
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },
    {
        'kylechui/nvim-surround',
        version = "*",
        event = "VeryLazy",
        config = true,
    },
    {
        'stevearc/oil.nvim',
        opts = {
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
        },
    },
    {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            -- Keymaps
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
            vim.keymap.set("n", "C-e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {
            map_c_h = true,
            map_c_w = true,
        },
    },
    {
        'pteroctopus/faster.nvim',
        opts = {}
    },
    {
        'NMAC427/guess-indent.nvim',
        config = function()
            require('guess-indent').setup({
                auto_cmd = true,
                override_editorconfig = false,
                filetype_exclude = {
                    "netrw",
                    "tutor",
                },
                buftype_exclude = {
                    "help",
                    "nofile",
                    "terminal",
                    "prompt",
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = true,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        "xiyaowong/transparent.nvim",
        config = true,
    },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup {
                input_buffer_type = "dressing",
            }
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                globalstatus = true,
                -- theme = "powerline",
            }
        }
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    },
    {
        "tadmccorkle/markdown.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
