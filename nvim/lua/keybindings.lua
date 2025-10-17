vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = false }

vim.g.copilot_enabled = 1
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

-- 上下滚动浏览
map("n", "<C-j>", "10j", opt)
map("n", "<C-k>", "10k", opt)
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
-- map("n", "<C-h>", "<Plug>(CybuLastusedNext)", opt)
-- map("n", "<C-l>", "<Plug>(CybuLastusedPrev)", opt)
map("n", "<S-Tab>", "<Plug>(CybuNext)", opt)
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

-- leaderf
map("v", "<leader>g",
    ":<C-U><C-R>=printf('Leaderf! rg -F -t c -t py -t lua -t go -t cpp --nowrap -e %s ', leaderf#Rg#visual())<CR><CR>"
    , opt)
map("n", "<leader>f", ":Leaderf rg -i -t lua -t c -t cpp -t py -t sh<CR>", opt)
map("n", "<C-n>", ':LeaderfFunction <cr>', opt)
map("n", "mm", ":<C-U><C-R>=printf('Leaderf mru %s', '')<CR><CR>", opt)
vim.g.Lf_ShortcutF = '<C-p>'
vim.keymap.set('n', '<C-P>', ':Leaderf file<CR>', { silent = true })
map("n", "//", ":LeaderfLine <cr>", opt)
-- vim.g.Lf_WorkingDirectoryMode = 'AF'
-- vim.g.Lf_RootMarkers = ".git, .svn, .hg, .project, .root"

-- vim.g.Lf_WindowPosition = 'popup'
-- vim.g.Lf_PreviewInPopup = 1

-- vim-easymotion
-- 忽略大小写
vim.g.EasyMotion_smartcase = 1
map("n", ";;", "<Plug>(easymotion-s2)", opt)
-- map("n", "sJ", "<Plug>(easymotion-t2)", opt)

-- 注释
map("v", "/", "<Plug>Commentary", opt)

-- Lua格式化
map("n", "sf", ":lua vim.lsp.buf.format()<CR>", opt)

-- 翻译
map("n", "st", ":Ydc<CR>", opt)
map("n", "<C-t>", ":<C-u>Yde<CR>", opt)

-- cpp源/头之间切换
map("n", "<C-o>", ":ClangdSwitchSourceHeader<CR>", opt)

-- vim-tab
-- 切换最近打开的页签
-- map("n", "<S-Tab>", ":TabberSelectLastActive<CR>", opt)
-- map("n", "<S-Tab>", ":echo 'Shift+Tab worked!<CR>'", opt)
map("n", "<C-Tab>", ":echo 'Ctrl+Tab worked!'<CR>", opt)
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
pluginKeys.mapLSP = function(mapbuf)
    --     -- rename
    --     -- 打开/关闭终端
    --     -- mapbuf("n", "<C-b>", "<cmd>Lspsaga term_toggle<CR>", opt)
    --     -- vim.keymap.set("t", "<C-b>", [[<C-\><C-n><cmd>Lspsaga term_toggle<CR>]], { silent = true })
end

vim.keymap.set('n', 'gm', function()
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

vim.keymap.set('n', 'qq', function()
    -- 创建浮动窗口
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = 80,
        height = 30,
        col = (vim.o.columns - 60) / 2,
        row = (vim.o.lines - 10) / 2,
        style = 'minimal',
        border = 'rounded'
    })

    -- 写入页签信息
    local lines = {}
    for i = 1, vim.fn.tabpagenr('$') do
        local bufname = vim.fn.bufname(vim.fn.tabpagebuflist(i)[1])
        table.insert(lines, string.format("%2d: %s", i, bufname))
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- 设置键位
    vim.keymap.set('n', '<CR>', function()
        local line = vim.fn.line('.')
        vim.api.nvim_win_close(win, true)
        vim.cmd('tabnext ' .. line)
    end, { buffer = buf })

    vim.keymap.set('n', 'q', function()
        vim.api.nvim_win_close(win, true)
    end, { buffer = buf })

    -- 添加数字键1-9映射
    for i = 1, 9 do
        vim.keymap.set('n', tostring(i), function()
            if i <= vim.fn.tabpagenr('$') then
                vim.api.nvim_win_close(win, true)
                vim.cmd('tabnext ' .. i)
            end
        end, { buffer = buf })
    end
end)

return pluginKeys
