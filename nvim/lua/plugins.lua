local vim = vim
local packer = require("packer")
packer.startup(
    function(use)
        -- Packer 可以管理自己本身
        use 'wbthomason/packer.nvim'

        -- 目录树
        use 'preservim/nerdtree'

        -- 底部信息插件
        use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
        use("arkav/lualine-lsp-progress")

        -- lua language server
        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        }

        -- lsp增强
        use 'nvimdev/lspsaga.nvim'

        -- 补全引擎
        use("hrsh7th/nvim-cmp")
        -- -- snippet 引擎
        use("hrsh7th/vim-vsnip")
        -- 补全源
        use("hrsh7th/cmp-vsnip")
        use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
        use("hrsh7th/cmp-buffer")   -- { name = 'buffer' },
        use("hrsh7th/cmp-path")     -- { name = 'path' }
        use("hrsh7th/cmp-cmdline")  -- { name = 'cmdline' }

        -- 常见编程语言代码段
        use("rafamadriz/friendly-snippets")

        -- 快速跳转
        -- use "easymotion/vim-easymotion"
        use "folke/flash.nvim"

        -- 替换
        use "nvim-pack/nvim-spectre"

        -- 快速注释
        use "numToStr/Comment.nvim"

        -- 翻译
        use "ianva/vim-youdao-translater"

        -- vim会话保存
        use "rmagatti/auto-session"

        -- 终端管理器
        use "numToStr/FTerm.nvim"

        -- 通知
        use 'rcarriga/nvim-notify'

        use {
            'akinsho/bufferline.nvim',
            requires = 'nvim-tree/nvim-web-devicons',
        }

        -- treesitter
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

        -- 主题
        use 'Shatur/neovim-ayu'

        use 'djoshea/vim-autoread' -- 自动检测文件外部修改并重新加载

        -- Telescope 核心插件
        use {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.6', -- 指定稳定版本，或使用 'latest'
            requires = {
                { 'nvim-lua/plenary.nvim' },
                -- 可选但推荐的扩展
                { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
                { 'nvim-telescope/telescope-ui-select.nvim' },
                { 'MunifTanjim/nui.nvim' },
            }
        }

        -- ai 补全
        use 'Exafunction/windsurf.vim'

    end)
