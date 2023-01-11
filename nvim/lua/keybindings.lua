vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = false }

-- 取消 s 默认功能
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- 左右比例控制
-- map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
-- map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
-- map("n", "s,", ":vertical resize -20<CR>", opt)
-- map("n", "s.", ":vertical resize +20<CR>", opt)
-- -- 上下比例
-- map("n", "sj", ":resize +10<CR>", opt)
-- map("n", "sk", ":resize -10<CR>", opt)
-- map("n", "<C-Down>", ":resize +2<CR>", opt)
-- map("n", "<C-Up>", ":resize -2<CR>", opt)
-- -- 等比例
-- map("n", "s=", "<C-w>=", opt)

map("n", "vv", "V", opt)
-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
map("n", "<C-j>", "5j", opt)
map("n", "<C-k>", "5k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- 退出
map("n", "<C-w>", ":q<CR>", opt)
map("n", "<C-s>", ":w<CR>", opt)
map("n", "<C-q>", ":qa!<CR>", opt)
map("n", "<C-c><C-c", "", opt)
map("n", "<Space>", "viw", opt)

-- nvim-tree
map("n", "<leader>t", ":NERDTreeToggle<CR>", opt)

-- winbar操作
map("n", "<C-h>", "gT<CR>", opt)
map("n", "<C-l>", "gt<CR>", opt)
map("n", "<S-h>", ":-tabmove<CR>", opt)
map("n", "<S-l>", ":+tabmove<CR>", opt)

-- leaderf
map("v", "<leader>g",
    ":<C-U><C-R>=printf('Leaderf! rg -F -t c -t py -t lua -t go -t cpp --nowrap --stayOpen -e %s ', leaderf#Rg#visual())<CR><CR>"
    , opt)
map("n", "<leader>f", ":Leaderf rg -i -t lua -t c -t cpp -t py -t sh<CR>", opt)
map("n", "<C-n>", ":LeaderfFunction <cr>", opt)
vim.g.Lf_ShortcutF = '<C-p>'
-- vim.g.Lf_WindowPosition = 'popup'
-- vim.g.Lf_PreviewInPopup = 1

-- vim-easymotion
-- 忽略大小写
vim.g.EasyMotion_smartcase = 1
map("n", "J", "<Plug>(easymotion-s2)", opt)
-- map("n", "sJ", "<Plug>(easymotion-t2)", opt)

-- 注释
map("v", "/", "<Plug>Commentary", opt)

-- Lua格式化
map("n", "sf", ":lua vim.lsp.buf.formatting_sync()<CR>", opt)

-- 翻译
map("n", "st", ":Ydc<CR>", opt)
map("n", "<C-t>", ":<C-u>Yde<CR>", opt)

-- cpp源/头之间切换
map("n", "<C-o>", ":ClangdSwitchSourceHeader<CR>", opt)

local pluginKeys = {}

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
    -- rename
    mapbuf("n", "<leader>r", "<cmd>Lspsaga rename<CR>", opt)

    -- code action:
    mapbuf("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)

    -- 跳转到定义
    mapbuf("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opt)
    -- 查看文档
    mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
    -- 搜索所有引用
    mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
    -- 打开警告的详细信息
    mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
    -- 跳转到下个错误
    mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
    -- 跳转到上个错误
    mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
    -- 打开终端
    mapbuf("n", "<C-i>", "<cmd>Lspsaga open_floaterm<CR>", opt)
    -- 关闭终端
    vim.keymap.set("t", "<C-i>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
end

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

return pluginKeys
