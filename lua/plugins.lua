return require("packer").startup(function(use)
    use 'nvim-lualine/lualine.nvim'
    use "rktjmp/lush.nvim"
    use "metalelf0/jellybeans-nvim"
    use "nvim-treesitter/nvim-treesitter"
    --use "tribela/vim-transparent"
    require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "rust" },
        sync_install = true,
        highlight = {
            enable = true,
        }
    }
    use { 'bluz71/vim-moonfly-colors', branch = 'cterm-compat' }
    use "wbthomason/packer.nvim"
    use {
        "ellisonleao/gruvbox.nvim", as = gruvbox,
    }
    use {'nyoom-engineering/oxocarbon.nvim'}
    use {
        "mattn/emmet-vim", as = emmet,
    }
    require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = true,
        strikethrough = true,
        contrast = "medium",
        transparent_mode = false,
        background = "light",
    })
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    require("nvim-tree").setup()
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    }
    require"mason".setup{}
    use 'folke/tokyonight.nvim'
    use "neovim/nvim-lspconfig"
    require"lspconfig".rust_analyzer.setup{}
    require"lspconfig".clangd.setup{}
    require"lspconfig".pyright.setup{}
    require"lspconfig".sumneko_lua.setup{}
    require"lspconfig".tsserver.setup({
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        }
      }
    })
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'MunifTanjim/eslint.nvim'
    local null_ls = require("null-ls")
    local eslint = require("eslint")

    null_ls.setup()

    eslint.setup({
      bin = 'eslint', -- or `eslint_d`
      code_actions = {
        enable = true,
        apply_on_save = {
          enable = true,
          types = { "directive", "problem", "suggestion", "layout" },
        },
        disable_rule_comment = {
          enable = true,
          location = "separate_line", -- or `same_line`
        },
      },
      diagnostics = {
        enable = true,
        report_unused_disable_directives = false,
        run_on = "type", -- or `save`
      },
    })
    use "lvimuser/lsp-inlayhints.nvim"
    require("lsp-inlayhints").setup()
    use "simrat39/rust-tools.nvim"
    --require('rust-tools').inlay_hints.enable()
    -- Completion framework:
    use 'hrsh7th/nvim-cmp'
    --require("lsp-inlayhints").on_attach(client, bufnr)

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    -- Or with configuration
    use({
      'projekt0n/github-nvim-theme', tag = 'v0.0.7',
    -- or                            branch = '0.0.x'
      config = function()
        require('github-theme').setup({
          -- ...
        })
      end
    })
    use {
        'tanvirtin/vgit.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    require"vgit".setup();
end)
