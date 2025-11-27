return {
    {
        "pants721/pantsbox",
        config = function()
            require("pantsbox").setup {
                contrast = "hard",
            }
            vim.cmd("colorscheme pantsbox")
        end,
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    {
        "pants721/pants-modus.nvim",
        config = function()
            -- vim.cmd("colorscheme modus_vivendi")
        end,
    },
    {
        "slugbyte/lackluster.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            -- vim.cmd.colorscheme("lackluster")
            -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
            -- vim.cmd.colorscheme("lackluster-mint")
        end,
    },
}
