local lspsaga
status, lspsaga = pcall(require, "lspsaga")
if not status then
    vim.notify("没有找到 lspsaga")
else
    lspsaga.setup({
        -- 预览定义
        preview = {
            lines_above = 0,
            lines_below = 10,
        },
        -- 滚动操作
        scroll_preview = {
            scroll_down = '<C-f>',
            scroll_up = '<C-b>',
        },
        -- 请求处理器
        request_timeout = 3000,
        -- 符号查找
        finder = {
            edit = { 'o', '<CR>' },
            vsplit = 'v',
            split = 's',
            tabe = 't',
            quit = { 'q', '<ESC>' },
        },
        -- 定义预览
        definition = {
            edit = '<C-c>o',
            vsplit = '<C-c>v',
            split = '<C-c>i',
            tabe = '<C-c>t',
            quit = 'q',
        },
        -- 代码操作
        code_action = {
            num_shortcut = true,
            keys = {
                quit = 'q',
                exec = '<CR>',
            },
        },
        -- 悬停文档
        lightbulb = {
            enable = true,
            sign = true,
            sign_priority = 40,
            virtual_text = false,
        },
        -- 诊断
        diagnostic = {
            show_code_action = true,
            show_source = true,
            jump_num_shortcut = true,
            keys = {
                exec_action = 'o',
                quit = 'q',
            },
        },
        -- 符号轮廓
        outline = {
            win_position = 'right',
            win_width = 30,
            auto_preview = true,
            detail = true,
            auto_close = true,
            keys = {
                jump = 'o',
                expand_collapse = 'u',
                quit = 'q',
            },
        },
        -- 调用层次结构
        callhierarchy = {
            show_detail = false,
            keys = {
                edit = 'e',
                vsplit = 'v',
                split = 's',
                tabe = 't',
                jump = 'o',
                quit = 'q',
                expand_collapse = 'u',
            },
        },
        -- UI 设置
        ui = {
            title = true,
            border = 'single', -- "single", "double", "rounded", "solid", "shadow"
            winblend = 0,
            expand = '⊞',
            collapse = '⊟',
            code_action = '💡',
            incoming = ' ',
            outgoing = ' ',
            colors = {
                normal_bg = '#1d1536',
                title_bg = '#afd700',
            },
        },
    })
end
