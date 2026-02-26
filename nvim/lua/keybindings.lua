local vim = vim
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = false }

vim.g.copilot_enabled = 1
-- 取消 s 默认功能
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "<leader>v", ":vsp<CR>", opt)
map("n", "<leader>h", ":sp<CR>", opt)
map("n", "co", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
map("n", "<C-a>", "ggVG", opt)

map("n", "vv", "V", opt)
-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- 上下滚动浏览
map("n", "<C-j>", "10j", opt)
map("n", "<C-k>", "10k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- 退出
map("n", "<C-w>", "<cmd>bdelete<CR>", opt)
map("n", "<C-s>", ":w<CR>", opt)
map("n", "<C-q>", ":qa!<CR>", opt)
map("n", "<C-c><C-c", "", opt)
map("n", "<Space>", "viw", opt)

-- nvim-tree
map("n", "<leader>t", ":NERDTreeToggle<CR>", opt)

map("n", "<C-h>", "<cmd>BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", "<cmd>BufferLineCycleNext<CR>", opt)
map("n", "<S-h>", ":-tabmove<CR>", opt)
map("n", "<S-l>", ":+tabmove<CR>", opt)

-- 定义行号切换函数
local function toggle_line_numbers()
    local is_number = vim.wo.number
    local is_relative = vim.wo.relativenumber

    if not is_number and not is_relative then
        vim.wo.number = true
        print("行号模式: 绝对")
    else
        vim.wo.number = false
        vim.wo.relativenumber = false
        print("行号模式: 关闭")
    end
    local current = vim.diagnostic.config().signs
    vim.diagnostic.config({ signs = not current })
    print('Diagnostic signs:', current and 'OFF' or 'ON')
end

-- 绑定快捷键
vim.keymap.set('n', '<F2>', toggle_line_numbers, { noremap = true, silent = true, desc = "切换行号/诊断显示" })

-- 翻译
-- map("n", "st", ":Ydc<CR>", opt)
map("n", "<A-y>", ":<C-u>Yde<CR>", opt)

local pluginKeys = {}

-- lsp 回调函数快捷键设置
map("n", "<leader>r", "<cmd>Lspsaga rename<CR>", opt)

-- code action:
map("n", "fo", "<cmd>Lspsaga code_action<CR>", opt)

-- 显示定义
map("n", "fd", "<cmd>Lspsaga peek_definition<CR>", opt)
-- 跳转到定义
-- map("n", "gm", "<cmd>Lspsaga goto_definition<CR>", opt)
map("n", "fn", "<cmd>vsp | Lspsaga goto_definition<CR>", opt)
-- 查看文档
map("n", "fh", "<cmd>Lspsaga hover_doc<cr>", opt)
-- 搜索所有引用
map("n", "fr", "<cmd>Lspsaga finder<CR>", opt)
-- 打开警告的详细信息
map("n", "fp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
-- 跳转到下个错误
map("n", "fj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
-- 跳转到上个错误
map("n", "fk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
-- 打开预览
map("n", "fo", "<cmd>Lspsaga outline<cr>", opt)
-- 格式化
map("n", "ff", "<cmd>lua vim.lsp.buf.format()<CR>", opt)

pluginKeys.mapLSP = function(mapbuf)
    --     -- rename
    --     -- 打开/关闭终端
    --     -- mapbuf("n", "<C-b>", "<cmd>Lspsaga term_toggle<CR>", opt)
    --     -- vim.keymap.set("t", "<C-b>", [[<C-\><C-n><cmd>Lspsaga term_toggle<CR>]], { silent = true })
end

vim.keymap.set('n', 'fm', function()
    vim.cmd('tab split')     -- 新建标签页
    vim.lsp.buf.definition() -- 跳转到定义
end, { desc = 'Goto Definition in New Tab' })

vim.keymap.set("n", "K", "<Plug>(CybuPrev)")

-- nvim-cmp 快捷键设置
pluginKeys.cmp = function(cmp)
    return {
        -- 出现补全
        ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- 取消
        ["<A-,>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        -- 上一个
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<Tab>"] = cmp.mapping.select_next_item(),
        -- 确认
        -- 如果窗口内容太多，可以滚动
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    }
end

-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- codeium 快捷键
vim.keymap.set('i', '<A-o>', function() return vim.fn['codeium#Accept']() end,
    { expr = true, silent = true })
vim.keymap.set('i', '<A-n>', function() return vim.fn['codeium#CycleCompletions'](1) end,
    { expr = true, silent = true })
vim.keymap.set('i', '<A-m>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
    { expr = true, silent = true })
vim.keymap.set('i', '<A-x>', function() return vim.fn['codeium#Clear']() end,
    { expr = true, silent = true })

-- 设置 Ctrl + 数字键 直接跳转到对应位置的缓冲区
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", { noremap = true, silent = true })
end

return pluginKeys
