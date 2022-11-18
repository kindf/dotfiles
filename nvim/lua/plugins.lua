local packer = require("packer")
packer.startup(
    function(use)
        -- Packer 可以管理自己本身
        use 'wbthomason/packer.nvim'
        -- 主题插件
        use 'KeitaNakamura/neodark.vim'
        -- 目录树插件
        use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
        -- 底部信息插件
        use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
        use("arkav/lualine-lsp-progress")
        -- 模糊搜索插件
        use 'Yggdroot/LeaderF'
        -- lsp插件
        use("williamboman/nvim-lsp-installer")
        use({ "neovim/nvim-lspconfig" })
        -- 启动界面插件
        use 'mhinz/vim-startify'

        -- 补全引擎
        use("hrsh7th/nvim-cmp")
        -- snippet 引擎
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
    end)

-- 每次保存 plugins.lua 自动安装插件
pcall(
    vim.cmd,
    [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]
)
