-- 如果找不到lualine 组件，就不继续执行
local status, buffline = pcall(require, "bufferline")
if not status then
    vim.notify("没有找到 buffline")
else
    buffline.setup({
        options = {
            -- 基础设置
            diagnostics = "nvim_lsp",
            mode = "buffers", -- 显示 buffers 而非 tabs
            numbers = "ordinal", -- 显示序号 (none | ordinal | buffer_id)
            close_command = "bdelete! %d", -- 关闭命令
            right_mouse_command = "bdelete! %d", -- 右键关闭
            left_mouse_command = "buffer %d", -- 左键切换
            middle_mouse_command = nil, -- 中键命令
            indicator = { style = 'icon', icon = '▎' }, -- 当前buffer指示器
            buffer_close_icon = '', -- 关闭图标
            modified_icon = '●', -- 修改标记
            close_icon = '', -- 关闭按钮图标
            left_trunc_marker = '', -- 左侧截断标记
            right_trunc_marker = '', -- 右侧截断标记
            -- 名称格式化
            name_formatter = function(buf)
                return buf.name
            end,
            -- 排序策略
            sort_by = 'insert_after_current', -- 排序方式 (id | extension | directory | relative_directory | modified)
            separator_style = "slant",        -- 分隔符样式 (slant | padded_slant | thin | thick)
            enforce_regular_tabs = true,      -- 强制等宽tab
            always_show_bufferline = true,    -- 总是显示bufferline
            hover = { enabled = true, delay = 200, reveal = { 'close' } },
            -- 图标配置
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "left"
                }
            },
            -- 颜色配置
            color_icons = true,             -- 文件类型彩色图标
            show_buffer_icons = true,       -- 显示buffer图标
            show_buffer_close_icons = true, -- 显示关闭图标
            show_close_icon = true,         -- 显示右侧关闭按钮
            show_tab_indicators = true,     -- 显示tab指示器
            -- 性能优化
            max_name_length = 18,           -- 最大名称长度
            max_prefix_length = 15,         -- 最大前缀长度
            truncate_names = true,          -- 截断长名称
            persist_buffer_sort = true,     -- 保持排序
        },
        -- 高亮组配置
        highlights = {
            fill = { guibg = '#1e222a' },       -- 背景色
            background = { guibg = '#1e222a' }, -- 非活动buffer背景
            buffer_selected = {                 -- 当前选中buffer
                guifg = '#abb2bf',
                guibg = '#3e4452',
                gui = 'bold'
            },
            buffer_visible = { -- 可见buffer
                guifg = '#828997',
                guibg = '#2c323c'
            },
            close_button = { guifg = '#5c6370' }, -- 关闭按钮
            close_button_selected = { guifg = '#e06c75' },
            close_button_visible = { guifg = '#5c6370' },
            modified = { guifg = '#e5c07b' }, -- 修改标记
            modified_selected = { guifg = '#e5c07b' },
            modified_visible = { guifg = '#e5c07b' },
            separator = { -- 分隔符
                guifg = '#1e222a',
                guibg = '#1e222a'
            },
            separator_selected = {
                guifg = '#1e222a',
                guibg = '#1e222a'
            },
            separator_visible = {
                guifg = '#1e222a',
                guibg = '#1e222a'
            },
            indicator_selected = { -- 当前指示器
                guifg = '#61afef',
                guibg = '#3e4452'
            }
        }
    })
end


local status, cybu = pcall(require, "cybu")
if not status then
    vim.notify("没有找到 cybu")
else
    cybu.setup({
        position = {
            relative_to = "win", -- 相对窗口定位 (win | editor)
            anchor = "center", -- 锚点位置
        },
        style = {
            path = "relative", -- 路径显示方式 (relative | absolute | tail)
            border = "rounded", -- 边框样式
            separator = " ", -- 项目分隔符
            prefix = "", -- 项目前缀符号
            padding = 1, -- 内边距
            hide_buffer_id = true, -- 隐藏buffer ID
            devicons = {
                enabled = true, -- 启用文件图标
                colored = true, -- 彩色图标
            },
        },
        behavior = {
            mode = {
                switch = "immediate",
                view = "rolling",
            },-- 排序模式 (lastused | buffer_number)
            last_used = {
                switch = "on_close",
                view = "paging",
            },
            auto = {
                view = "rolling",
            },
            show_current = true, -- 显示当前buffer
            auto_select = false, -- 自动选择
            wrap_around = true, -- 循环导航
        },
        display_time = 750,  -- 窗口显示时间(ms)
        exclude = {          -- 排除的buffer类型
            "NvimTree",
            "terminal",
            "qf",
        },
    })
end
