return {
    -- Simple plugins with minimal config
    {
        "pants721/orca.nvim",
        lazy = true,
        config = function ()
            local orca = require("orca")
            orca.setup()
            vim.keymap.set("n", "<leader>o", function () orca:toggle_orca() end)
        end
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
            { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
        },
        opts = {},
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
        keys = {
            { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
            { "C-e", function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon menu" },
            { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
            { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
            { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
            { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
        },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("harpoon"):setup()
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
        event = "VeryLazy",
        opts = {}
    },
    {
        'NMAC427/guess-indent.nvim',
        event = { "BufReadPost", "BufNewFile" },
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
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        "xiyaowong/transparent.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = function()
            require("inc_rename").setup {
                input_buffer_type = "dressing",
            }
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
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
    -- {
    --     'MeanderingProgrammer/render-markdown.nvim',
    --     opts = {},
    --     dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    -- },
    -- {
    --     "tadmccorkle/markdown.nvim",
    --     event = "VeryLazy",
    --     opts = {},
    -- },
}
