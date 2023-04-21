return require("packer").startup(function(use)
    use 'nvim-lualine/lualine.nvim'
    use "rktjmp/lush.nvim"
    use "Metalelf0/jellybeans-nvim"
    use "nvim-treesitter/nvim-treesitter"
    --use "tribela/vim-transparent"
    use { 'bluz71/vim-moonfly-colors', branch = 'cterm-compat' }
    use "wbthomason/packer.nvim"
    use {
        "ellisonleao/gruvbox.nvim"
    }
    use { 'nyoom-engineering/oxocarbon.nvim' }
    use {
        "mattn/emmet-vim", as = emmet,
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    }
    use 'folke/tokyonight.nvim'
    use "neovim/nvim-lspconfig"
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'MunifTanjim/eslint.nvim'
    --use "lvimuser/lsp-inlayhints.nvim"
    use('simrat39/inlay-hints.nvim')
    use "simrat39/rust-tools.nvim"
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'
    use 'MunifTanjim/prettier.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use {
        'tanvirtin/vgit.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use 'mfussenegger/nvim-dap'
end)
