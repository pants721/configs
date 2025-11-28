return {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
        { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require('neogit').setup {
            kind = "replace",
        }

        require('diffview').setup {
            use_icons = false,
        }
    end
}
