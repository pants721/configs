return {
    "NeogitOrg/neogit",
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

        -- Keymaps
        vim.keymap.set('n', '<leader>gg', "<cmd>Neogit<cr>", { silent = true })
        vim.keymap.set('n', '<leader>gc', "<cmd>Neogit commit<cr>", { silent = true })
    end
}
