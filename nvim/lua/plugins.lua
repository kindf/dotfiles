local packer = require("packer")
packer.startup(
    function(use)
        -- Packer 可以管理自己本身
        use 'wbthomason/packer.nvim'
        -- 主题插件
        use 'KeitaNakamura/neodark.vim'
        -- 目录树插件
        -- use({ "nvim-tree/nvim-tree.lua"})
        use 'preservim/nerdtree'
        -- 底部信息插件
        use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
        use("arkav/lualine-lsp-progress")
        -- 模糊搜索插件
        use 'Yggdroot/LeaderF'
        -- lsp插件
        -- use("williamboman/nvim-lsp-installer")
        -- use({ "neovim/nvim-lspconfig" })

        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        }
        -- lsp增强
        -- use "glepnir/lspsaga.nvim"
        use ({
            'nvimdev/lspsaga.nvim',
            -- after = 'nvim-lspconfig',
            config = function()
                require('lspsaga').setup({})
            end,
        })
        -- 启动界面插件
        -- use 'mhinz/vim-startify'

        -- 补全引擎
        use("hrsh7th/nvim-cmp")
        -- -- snippet 引擎
        use("hrsh7th/vim-vsnip")
        -- 补全源
        use("hrsh7th/cmp-vsnip")
        use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
        use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
        use("hrsh7th/cmp-path") -- { name = 'path' }
        use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

        -- 常见编程语言代码段
        use("rafamadriz/friendly-snippets")

        -- 快速跳转
        use "easymotion/vim-easymotion"
        -- 快速注释
        use "tpope/vim-commentary"
        -- 翻译
        use "ianva/vim-youdao-translater"
        -- vim会话保存
        use "rmagatti/auto-session"
        -- use { "pysan3/autosession.nvim" }

        -- 通知
        use 'rcarriga/nvim-notify'
    end)

-- 每次保存 plugins.lua 自动安装插件
pcall(
    vim.cmd,
    [[
augroup packer_user_config
autocmd!
autoclualinemd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]
)
