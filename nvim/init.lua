require('basic')
require('plugins')
require('plugin-config.colorscheme')
require('plugin-config.lualine')
require('plugin-config.autosession')
-- require('plugin-config.buffline')
require('plugin-config.lspsaga')
require('lsp.setup')
require('lsp.cmp')

local ok, treesitter = pcall(require "nvim-treesitter.configs")
if ok then
    treesitter.setup({
        ensure_installed = { "c", "lua", "python", "bash", "json" }, -- 自动安装语言解析器
        sync_install = false,                                  -- 异步安装
        auto_install = true,                                   -- 自动检测并安装缺失解析器

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false, -- 禁用传统高亮
        },

        indent = { enable = true }, -- 智能缩进
        incremental_selection = { -- 增量选择
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
    })
else
    vim.notify("没有找到 treesitter")
end

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local clients = vim.lsp.get_active_clients({bufnr = args.buf})
--     if #clients > 1 then
--       print("警告：多个 LSP 客户端附加到缓冲区:", vim.inspect(clients))
--     end
--   end,
-- })

require('keybindings')
require('plugin-config.diagnostic_underline')
