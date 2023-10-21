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


local ok, lazy = pcall(require, "lazy")
if not ok then
	return
end

lazy.setup({
	{
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
	},
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    {
        -- integrate with lualine
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'linrongbin16/lsp-progress.nvim',
        },
        config = ...
    },
    {
        'sainnhe/gruvbox-material'
    },
    {
        'sekke276/dark_flat.nvim',
        opts = {
            transparent = true,
        }
    },
    {
        'windwp/nvim-ts-autotag'
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        'xiyaowong/transparent.nvim',
        opts = {
        }
    },
    {
        'lewis6991/gitsigns.nvim'
    },
    {
        {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},

        --- Uncomment these if you want to manage LSP servers from neovim
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- LSP Support
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                {'hrsh7th/cmp-nvim-lsp'},
            },
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                {'L3MON4D3/LuaSnip'},
            }
        },
    }
})

