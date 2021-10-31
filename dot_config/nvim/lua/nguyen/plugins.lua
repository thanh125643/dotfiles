local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
    vim.cmd 'packadd packer.nvim'
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({
    function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons'
        }
        use {
            'hoob3rt/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true}
        }
        use 'ntk148v/vim-horizon'
        use 'morhetz/gruvbox'
        use 'jacoborus/tender.vim'
        use 'joshdick/onedark.vim'

        use 'kabouzeid/nvim-lspinstall'
        use 'neovim/nvim-lspconfig'

        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/nvim-cmp'
        use 'L3MON4D3/LuaSnip'
        use 'saadparwaiz1/cmp_luasnip'

        use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
        use {'nvim-treesitter/nvim-treesitter-textobjects'}
        use 'JoosepAlviste/nvim-ts-context-commentstring'
        use 'nvim-treesitter/nvim-treesitter-refactor'
        use 'p00f/nvim-ts-rainbow'
        use 'romgrk/nvim-treesitter-context'
        use 'windwp/nvim-ts-autotag'
        use 'RRethy/nvim-treesitter-textsubjects'

        use 'windwp/nvim-autopairs'
        use 'Yggdroot/indentLine'

        use {
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

        use 'svermeulen/vimpeccable'
        use 'tpope/vim-repeat'
        use 'b3nj5m1n/kommentary'

        use {'vimwiki/vimwiki', branch = "dev"}
        use 'vim-pandoc/vim-pandoc'
        use 'vim-pandoc/vim-pandoc-syntax'
        use 'plasticboy/vim-markdown'
        use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}

        use_rocks {'luaformatter', server = 'https://luarocks.org/dev'}
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({border = 'single'})
            end
        }
    }
})
