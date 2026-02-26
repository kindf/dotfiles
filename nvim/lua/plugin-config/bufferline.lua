local vim = vim
local status, bufferline = pcall(require, "bufferline")
if not status then
    return vim.notify("没有找到 bufferline")
end
bufferline.setup({
    options = {
        -- 基础设置
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        separator_style = "thick",
        mode = "buffers", -- 显示 buffers 而非 tabs
        numbers = "ordinal", -- 显示序号 (none | ordinal | buffer_id)
        close_command = "bdelete! %d", -- 关闭命令
        right_mouse_command = "bdelete! %d", -- 右键关闭
        left_mouse_command = "buffer %d", -- 左键切换
        middle_mouse_command = nil, -- 中键命令
        indicator = { style = 'icon', icon = '▎' }, -- 当前buffer指示器
        buffer_close_icon = '', -- 关闭图标
        modified_icon = '●', -- 修改标记
        close_icon = '', -- 关闭按钮图标
        left_trunc_marker = '', -- 左侧截断标记
        right_trunc_marker = '', -- 右侧截断标记
        -- 排序策略
        sort_by = 'id', -- 排序方式 (id | extension | directory | relative_directory | modified)
        separator_style = "slant", -- 分隔符样式 (slant | padded_slant | thin | thick)
        -- enforce_regular_tabs = true,      -- 强制等宽tab
        always_show_bufferline = true, -- 总是显示bufferline
        show = "all",
        hover = { enabled = true, delay = 200, reveal = { 'close' } },
        name_formatter = function(buf)
            return buf.name
        end,
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
        show_tab_indicators = false,    -- 显示tab指示器
        -- 性能优化
        max_name_length = 18,           -- 最大名称长度
        max_prefix_length = 15,         -- 最大前缀长度
        truncate_names = true,          -- 截断长名称
        persist_buffer_sort = true,     -- 保持排序
    },
})
