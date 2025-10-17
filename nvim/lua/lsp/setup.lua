require("mason").setup()
-- require("mason-lspconfig").setup({
--   automatic_installation = true,
--   automatic_setup = false, -- 禁用自动调用 setup
-- })

local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')
-- lua_ls设置：https://luals.github.io/wiki/settings/#completionautorequire

require("lspconfig").lua_ls.setup {
    root_dir = function() return vim.fn.getcwd() end,  -- 避免不同实例冲突
    settings = {
        Lua = {
            runtime = {
                version = "Lua 5.3",
                path = lua_runtime_path,
            },
            -- 补全设置
            completion = {
                -- callSnippet = "Both",
                displayContext = 5, -- 自动补全时，预览定义周围行数，0表示不启用
                keywordSnippet = "Both",
            },
            -- 诊断设置
            diagnostics = {
                -- globals = { 'vim', "require", "table" },
                -- disable = { "undefined-global" },  -- 禁用未定义全局变量的警告
                severity = {
                    -- ["undefined-global"] = "hint", -- 改为警告（默认是 error）
                },
            },
        }
    },
    on_attach = function(client, bufnr)
        -- 禁用格式化功能，交给专门插件插件处理
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false

        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        -- 绑定快捷键
        require('keybindings').mapLSP(buf_set_keymap)
        -- 保存时自动格式化
        -- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
    end,
}

require("lspconfig").clangd.setup {
    init_options = {
        clangdFileStatus = true
    },
    on_attach = function(client, bufnr)
        -- 禁用格式化功能，交给专门插件插件处理
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false

        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        -- 绑定快捷键
        require('keybindings').mapLSP(buf_set_keymap)
        -- 保存时自动格式化
        -- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
    end,
}

require('lspconfig').buf_ls.setup({
    cmd = { "buf-language-server", "--stdio" },
    filetypes = { "proto" },
    -- root_dir = lsp.util.root_pattern("buf.yaml", "buf.work.yaml", ".git"),
    settings = {
        buf = {
            -- 可选：禁用未使用的依赖警告
            disableUnusedDependencyWarning = true,
            fileWatcher = true                 -- 启用文件监听
        }
    }
})

require('lspconfig').ts_ls.setup({
    on_attach = function(client, bufnr)
        -- 你的按键映射等配置
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
            }
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all', 
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
            }
        }
    }
})
