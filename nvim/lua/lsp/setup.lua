local vim = vim
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
    root_dir = function() return vim.fn.getcwd() end, -- 避免不同实例冲突
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
