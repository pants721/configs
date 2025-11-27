return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'windwp/nvim-ts-autotag',
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    branch = "master",
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "c", "lua", "vim", "cpp", "python", "rust", "markdown", "toml", "go", "haskell" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                disable = {
                    function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    "lua",
                    "vimdoc",
                },

                additional_vim_regex_highlighting = { "markdown" },
            },
            indent = {
                enable = true
            },
            autotag = {
                enable = true,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                },
            },
        }
    end
}
