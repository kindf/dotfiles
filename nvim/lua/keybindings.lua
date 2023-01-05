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
    ":<C-U><C-R>=printf('Leaderf! rg -F -t c -t py -t lua -t go --nowrap --stayOpen -e %s ', leaderf#Rg#visual())<CR><CR>"
    , opt)
map("n", "<leader>f", ":Leaderf rg -i -t lua -t c -t cpp -t py -t sh<CR>", opt)
map("n", "<C-n>", ":LeaderfFunction <cr>", opt)
vim.g.Lf_ShortcutF = '<C-p>'
-- vim.g.Lf_WindowPosition = 'popup'
-- vim.g.Lf_PreviewInPopup = 1

-- vim-easymotion
-- 忽略大小写
vim.g.EasyMotion_smartcase = 1
map("n", "sj", "<Plug>(easymotion-s2)", opt)
map("n", "sJ", "<Plug>(easymotion-t2)", opt)

-- 注释
map("v", "/", "<Plug>Commentary", opt)

-- Lua格式化
map("n", "sf", ":lua vim.lsp.buf.formatting_sync()<CR>", opt)

-- 翻译
map("n", "st", ":Ydc<CR>", opt)
map("n", "<C-t>", ":<C-u>Yde<CR>", opt)

local pluginKeys = {}

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
    -- rename
    -- mapbuf("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
    mapbuf("n", "<leader>r", "<cmd>Lspsaga rename<CR>", opt)

    -- code action:
    -- mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
    mapbuf("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)

    -- go xx
    mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
    mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
    mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
    mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
    mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
    mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
    -- mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
    -- mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
    -- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
    -- mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
    -- mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
    -- diagnostic
    -- mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
    -- mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
    -- mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
    -- mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
    --
    -- 没用到
    -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
    -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
    -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
    -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
    -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
    -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
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
