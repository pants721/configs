-- super based off of jon gjengset's vim config https://github.com/jonhoo/configs

-- set leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

vim.opt.undofile = true

local tabwidth = 4
vim.opt.shiftwidth = tabwidth
vim.opt.softtabstop = tabwidth
vim.opt.tabstop = tabwidth
vim.opt.expandtab = false

vim.opt.ignorecase = true

vim.opt.smartcase = true

vim.cmd "set rnu nu"

vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'yes'
vim.opt.guicursor = 'i:block'

vim.cmd "set termguicolors"
vim.opt.clipboard = "unnamedplus"

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
vim.keymap.set('t', 'jk', '<Esc>')
-- Ctrl+j and Ctrl+k as Esc
vim.keymap.set('n', '<C-j>', '<Esc>')
vim.keymap.set('i', '<C-j>', '<Esc>')
vim.keymap.set('v', '<C-j>', '<Esc>')
vim.keymap.set('s', '<C-j>', '<Esc>')
vim.keymap.set('x', '<C-j>', '<Esc>')
vim.keymap.set('c', '<C-j>', '<Esc>')
vim.keymap.set('o', '<C-j>', '<Esc>')
vim.keymap.set('l', '<C-j>', '<Esc>')
vim.keymap.set('t', '<C-j>', '<Esc>')
-- Ctrl-j is a little awkward unfortunately:
-- https://github.com/neovim/neovim/issues/5916
-- So we also map Ctrl+k
vim.keymap.set('n', '<C-k>', '<Esc>')
vim.keymap.set('i', '<C-k>', '<Esc>')
vim.keymap.set('v', '<C-k>', '<Esc>')
vim.keymap.set('s', '<C-k>', '<Esc>')
vim.keymap.set('x', '<C-k>', '<Esc>')
vim.keymap.set('c', '<C-k>', '<Esc>')
vim.keymap.set('o', '<C-k>', '<Esc>')
vim.keymap.set('l', '<C-k>', '<Esc>')
vim.keymap.set('t', '<C-k>', '<Esc>')
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
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

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
	-- {
	-- 	"morhetz/gruvbox",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme gruvbox]])
	-- 		vim.o.background = 'dark'
	-- 	end
	-- },
	{
		"wincent/base16-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
			vim.o.background = 'dark'
			-- XXX: hi Normal ctermbg=NONE
			-- Make comments more prominent -- they are important.
			local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
			vim.api.nvim_set_hl(0, 'Comment', bools)
			-- Make it clearly visible which argument we're at.
			local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
			vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
			-- XXX
			-- Would be nice to customize the highlighting of warnings and the like to make
			-- them less glaring. But alas
			-- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
			-- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
		end
	},
	{
		'nvim-lualine/lualine.nvim',
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
					theme = 'powerline',
					-- component_separators = { left = '', right = ''},
					-- section_separators = { left = '', right = ''},
					component_separators = { left = '', right = '' },
					section_separators = { left = '', right = '' },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					always_divide_middle = true,
					globalstatus = true,
				},
			}
		end,
	},

	-- quick navigation
	-- {
	--     'ggandor/leap.nvim',
	--     config = function()
	--         require('leap').create_default_mappings()
	--     end
	-- },
	-- better %
	-- {
	-- 	'andymass/vim-matchup',
	-- 	config = function()
	-- 		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	-- 	end
	-- },
	-- auto-cd to root of git project
	-- 'airblade/vim-rooter'
	{
		'notjedi/nvim-rooter.lua',
		config = function()
			require('nvim-rooter').setup()
		end
	},
	-- Version control
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"sindrets/diffview.nvim",        -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			require('neogit').setup {}
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
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {
						capabilities = require('cmp_nvim_lsp').default_capabilities()
					}
				end,
			}
			local lspconfig = require('lspconfig')

			-- Rust
			-- lspconfig.rust_analyzer.setup {
			-- 	-- Server-specific settings. See `:help lspconfig-setup`
			-- 	settings = {
			-- 		["rust-analyzer"] = {
			-- 			cargo = {
			-- 				allFeatures = true,
			-- 			},
			-- 			completion = {
			-- 				postfix = {
			-- 					enable = false,
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- }

			-- Bash LSP
			local configs = require 'lspconfig.configs'
			if not configs.bash_lsp and vim.fn.executable('bash-language-server') == 1 then
				configs.bash_lsp = {
					default_config = {
						cmd = { 'bash-language-server', 'start' },
						filetypes = { 'sh' },
						root_dir = require('lspconfig').util.find_git_ancestor,
						init_options = {
							settings = {
								args = {}
							}
						}
					}
				}
			end
			if configs.bash_lsp then
				lspconfig.bash_lsp.setup {}
			end

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
					vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<leader>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
					-- *and* there's some way to make it only apply to the current line.
					-- if client.server_capabilities.inlayHintProvider then
					--     vim.lsp.inlay_hint(ev.buf, true)
					-- end

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
		},
		config = function()
			local cmp = require 'cmp'
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
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require("telescope").setup {
				-- pickers = {
				-- 	find_files = {
				-- 		theme = "ivy",
				-- 	},
				-- 	live_grep = {
				-- 		theme = "ivy",
				-- 	}
				-- }
			}
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
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
	-- toml
	'cespare/vim-toml',
	-- yaml
	{
		"cuducos/yaml.nvim",
		ft = { "yaml" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		'plasticboy/vim-markdown',
		ft = { "markdown" },
		dependencies = {
			'godlygeek/tabular',
		},
		config = function()
			-- never ever fold!
			vim.g.vim_markdown_folding_disabled = 1
			-- support front-matter in .md files
			vim.g.vim_markdown_frontmatter = 1
			-- 'o' on a list item should insert at same level
			vim.g.vim_markdown_new_list_item_indent = 0
			-- don't add bullets when wrapping:
			-- https://github.com/preservim/vim-markdown/issues/232
			vim.g.vim_markdown_auto_insert_bullets = 0
		end
	},
	-- Commentary
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	-- {
	-- 	'nvim-treesitter/nvim-treesitter',
	-- 	config = function()
	-- 		require'nvim-treesitter.configs'.setup {
	-- 			-- A list of parser names, or "all" (the five listed parsers should always be installed)
	-- 			ensure_installed = { "c", "lua", "vim", "cpp", "python", "rust" },
	-- 			-- Install parsers synchronously (only applied to `ensure_installed`)
	-- 			sync_install = false,
	-- 			-- Automatically install missing parsers when entering buffer
	-- 			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	-- 			auto_install = true,
	-- 			highlight = {
	-- 				enable = true,
	--
	-- 				-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
	-- 				-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
	-- 				-- the name of the parser)
	-- 				-- list of language that will be disabled
	-- 				-- disable = { "c", "rust" },
	-- 				-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
	-- 				disable = function(lang, buf)
	-- 					local max_filesize = 100 * 1024 -- 100 KB
	-- 					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	-- 					if ok and stats and stats.size > max_filesize then
	-- 						return true
	-- 					end
	-- 				end,
	--
	-- 				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	-- 				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	-- 				-- Using this option may slow down your editor, and you may see some duplicate highlights.
	-- 				-- Instead of true it can also be a list of languages
	-- 				additional_vim_regex_highlighting = false,
	-- 			},
	-- 		}
	-- 	end
	-- },
	-- Autoclose ur brackets
	{
		"m4xshen/autoclose.nvim",
		opts = {},
	},
	-- Find files quickly
	{
		"ThePrimeagen/harpoon",
		config = function()
			vim.keymap.set("n", "<leader>q", require("harpoon.mark").add_file)
			vim.keymap.set("n", "<leader>h", require("harpoon.ui").toggle_quick_menu)

			vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end)
			vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end)
			vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end)
			vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end)
		end
	}
})
