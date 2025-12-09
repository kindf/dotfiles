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

        -- Buf 语言服务器配置
        use {
            'bufbuild/buf-language-server',
            run = 'npm install -g @bufbuild/buf-language-server', -- 可选：通过 Packer 自动安装
        }

        -- lsp增强
        use({
            'nvimdev/lspsaga.nvim',
            -- after = 'nvim-lspconfig',
        })

        -- 可选：调试虚拟文本提示
        use 'theHamsta/nvim-dap-virtual-text'
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

        -- 快速注释
        use "numToStr/Comment.nvim"

        -- 翻译
        use "ianva/vim-youdao-translater"
        -- vim会话保存
        use "rmagatti/auto-session"
        -- use { "pysan3/autosession.nvim" }

        -- 通知
        use 'rcarriga/nvim-notify'

        use {
            'akinsho/bufferline.nvim',
            requires = 'nvim-tree/nvim-web-devicons',
        }

        -- treesitter
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        --

        -- 主题
        use {
            'Shatur/neovim-ayu',
            -- branch = 'master',
        }

        use 'djoshea/vim-autoread'  -- 自动检测文件外部修改并重新加载

         -- Telescope 核心插件
         use {
             'nvim-telescope/telescope.nvim',
             tag = '0.1.6',  -- 指定稳定版本，或使用 'latest'
             requires = {
                 {'nvim-lua/plenary.nvim'},
                 -- 可选但推荐的扩展
                 {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
                 {'nvim-telescope/telescope-ui-select.nvim'},
                 {'MunifTanjim/nui.nvim'},
             }
         }
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
