local M = {}

-- 测试终端是否支持 undercurl (运行指令 ": TestUndercurl")
vim.api.nvim_create_user_command('TestUndercurl', function()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(buf)

    -- 创建测试文本显示不同下划线样式
    local test_lines = {
        "=== 下划线样式测试 ===",
        "",
        "1. 波浪下划线 (undercurl):",
        "   这行文本应该有红色波浪线",
        "",
        "2. 直线下划线 (underline):",
        "   这行文本应该有黄色直线",
        "",
        "3. 普通文本:",
        "   这行应该没有特殊样式"
    }

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, test_lines)

    -- 添加语法高亮来测试 undercurl
    vim.cmd('syntax match TestUndercurl "红色波浪线"')
    vim.cmd('syntax match TestUnderline "黄色直线"')

    vim.cmd('highlight TestUndercurl gui=undercurl guisp=red cterm=undercurl')
    vim.cmd('highlight TestUnderline gui=underline cterm=underline')

    print("🧪 下划线测试已创建")
    print("🔍 观察第4行和第7行的下划线样式")
    print("💡 如果看不到波浪线，你的终端可能不支持 undercurl")
end, {})

-- 全面的终端能力测试
vim.api.nvim_create_user_command('TestTerminalCapabilities', function()
    local buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_set_current_buf(buf)

    local test_content = {
        "=== 终端能力测试 ===",
        "",
        "1. 基本样式测试:",
        "   " .. "粗体文字 (bold)",
        "   " .. "斜体文字 (italic)",
        "   " .. "下划线文字 (underline)",
        "   " .. "波浪下划线 (undercurl)",
        "",
        "2. 颜色测试:",
        "   " .. "红色文字",
        "   " .. "绿色文字",
        "   " .. "蓝色文字",
        "",
        "3. 组合样式测试:",
        "   " .. "粗体+下划线",
        "   " .. "红色+下划线",
        "   " .. "粗体+红色+下划线",
        "",
        "4. 诊断样式模拟:",
        "   " .. "错误下划线模拟",
        "   " .. "警告下划线模拟",
    }

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, test_content)

    -- 应用语法高亮来测试各种样式
    vim.cmd([[
        syntax match BoldTest /粗体文字/
        syntax match ItalicTest /斜体文字/
        syntax match UnderlineTest /下划线文字/
        syntax match UndercurlTest /波浪下划线/

        syntax match RedText /红色文字/
        syntax match GreenText /绿色文字/
        syntax match BlueText /蓝色文字/

        syntax match BoldUnderline /粗体\+下划线/
        syntax match RedUnderline /红色\+下划线/
        syntax match BoldRedUnderline /粗体\+红色\+下划线/

        syntax match ErrorSimulate /错误下划线模拟/
        syntax match WarnSimulate /警告下划线模拟/
    ]])

    -- 设置高亮
    vim.cmd([[
        highlight BoldTest gui=bold cterm=bold
        highlight ItalicTest gui=italic cterm=italic
        highlight UnderlineTest gui=underline cterm=underline
        highlight UndercurlTest gui=undercurl cterm=undercurl

        highlight RedText guifg=red ctermfg=red
        highlight GreenText guifg=green ctermfg=green
        highlight BlueText guifg=blue ctermfg=blue

        highlight BoldUnderline gui=bold,underline cterm=bold,underline
        highlight RedUnderline guifg=red gui=underline ctermfg=red cterm=underline
        highlight BoldRedUnderline guifg=red gui=bold,underline ctermfg=red cterm=bold,underline

        highlight ErrorSimulate gui=undercurl guisp=red cterm=undercurl
        highlight WarnSimulate gui=undercurl guisp=yellow cterm=undercurl
    ]])

    print("🧪 终端能力测试已创建")
    print("👀 请观察各种样式是否正常显示")
    print("💡 特别是 '波浪下划线' 和诊断模拟样式")
end, {})

-- 增强直线下划线，让它们更加明显
local function enhance_underline_visibility()
    -- 更粗、更明显的直线下划线
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', {
        underline = true,
        fg = '#ff0000', -- 更亮的红色
        bold = true,
        -- 在 tmux 中，underline 可能不支持 sp，使用 fg
    })

    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', {
        underline = true,
        fg = '#ff9900', -- 更亮的橙色
        bold = true,
    })

    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', {
        underline = true,
        fg = '#0099ff', -- 更亮的蓝色
    })

    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', {
        underline = true,
        fg = '#00cc66', -- 更亮的绿色
    })
end

-- 让符号和虚拟文本更加醒目
local function enhance_icons_and_text()
    -- 更醒目的符号
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "E>", -- 更明显的停止符号
                [vim.diagnostic.severity.WARN] = "W>",  -- 大橙色菱形
                [vim.diagnostic.severity.INFO] = "I>",  -- 大蓝色菱形
                [vim.diagnostic.severity.HINT] = "H>",  -- 菱形点
            },
        },
        virtual_text = {
            source = "always",
            prefix = function(diagnostic)
                local icons = {
                    [vim.diagnostic.severity.ERROR] = '❌', -- 大叉号
                    [vim.diagnostic.severity.WARN] = '⚠️', -- 大警告三角
                    [vim.diagnostic.severity.INFO] = 'ℹ️', -- 信息图标
                    [vim.diagnostic.severity.HINT] = '💡', -- 灯泡
                }
                return icons[diagnostic.severity] .. ' '
            end,
            format = function(diagnostic)
                -- 根据严重性添加前缀
                local prefixes = {
                    [vim.diagnostic.severity.ERROR] = '[错误] ',
                    [vim.diagnostic.severity.WARN] = '[警告] ',
                    [vim.diagnostic.severity.INFO] = '[信息] ',
                    [vim.diagnostic.severity.HINT] = '[提示] ',
                }
                return prefixes[diagnostic.severity] .. diagnostic.message
            end
        },
    })

    -- 增强虚拟文本高亮
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', {
        fg = '#ff6b6b',
        bg = '#330000', -- 深红色背景
        bold = true,
        underline = true,
    })

    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', {
        fg = '#ffd93d',
        bg = '#332200', -- 深黄色背景
        bold = true,
        underline = true,
    })

    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', {
        fg = '#4dabf7',
        bg = '#002233',
        bold = true,
    })

    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', {
        fg = '#69db7c',
        bg = '#003322',
        bold = true,
    })
end

local function enhance_float_window()
    vim.diagnostic.config({
        float = {
            border = "double", -- 更明显的双线边框
            header = {
                "🐛 诊断信息 🐛",
                "────────────────",
            },
            prefix = function(diagnostic)
                local icons = {
                    [vim.diagnostic.severity.ERROR] = '🛑 错误: ',
                    [vim.diagnostic.severity.WARN] = '🔸 警告: ',
                    [vim.diagnostic.severity.INFO] = '🔹 信息: ',
                    [vim.diagnostic.severity.HINT] = '💠 提示: ',
                }
                return icons[diagnostic.severity]
            end,
            format = function(diagnostic)
                return diagnostic.message
            end,
        },
    })

    -- 浮动窗口样式
    vim.api.nvim_set_hl(0, 'FloatBorder', {
        fg = '#ff6b6b',
        bg = '#1a1a1a',
    })
end

enhance_float_window()
enhance_underline_visibility()
enhance_icons_and_text()

return M
