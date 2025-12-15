local vim = vim
local function setup_ctrl_n_switcher()
    local recent_buffers = {} -- 存储按访问时间排序的缓冲区
    local last_time = 0
    local current_index = 1
    local close_timer = nil
    local float_win, float_buf
    local is_switching = false -- 标记是否正在连续切换

    -- 按访问时间排序（最近使用的在前）
    local function update_recent_buffers()
        local current_buf = vim.api.nvim_get_current_buf()
        local valid_buffers = vim.tbl_filter(function(buf)
            return vim.api.nvim_buf_is_valid(buf) and
                vim.api.nvim_buf_get_option(buf, 'buflisted') and
                vim.api.nvim_buf_is_loaded(buf) and
                vim.bo[buf].buftype == "" -- 只包括普通文件缓冲区
        end, vim.api.nvim_list_bufs())

        -- 如果当前缓冲区不在列表中，添加到开头
        if not vim.tbl_contains(recent_buffers, current_buf) then
            table.insert(recent_buffers, 1, current_buf)
        else
            -- -- 如果已经在列表中，移动到最前面（最近访问）
            -- recent_buffers = vim.tbl_filter(function(buf)
            --     return buf ~= current_buf
            -- end, recent_buffers)
            -- table.insert(recent_buffers, 1, current_buf)
        end

        -- 确保所有有效缓冲区都在列表中
        for _, buf in ipairs(valid_buffers) do
            if not vim.tbl_contains(recent_buffers, buf) then
                table.insert(recent_buffers, buf)
            end
        end

        -- 移除无效缓冲区
        recent_buffers = vim.tbl_filter(function(buf)
            return vim.tbl_contains(valid_buffers, buf)
        end, recent_buffers)

        -- 限制列表长度，只保留最近使用的
        if #recent_buffers > 10 then
            recent_buffers = { table.unpack(recent_buffers, 1, 10) }
        end

        -- 更新当前索引
        for i, buf in ipairs(recent_buffers) do
            if buf == current_buf then
                current_index = i
                break
            end
        end
    end

    -- 获取缓冲区显示信息
    local function get_buffer_display_info(bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        local display_name = name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":t")
        local file_path = name == "" and "" or vim.fn.fnamemodify(name, ":~:.")
        return display_name, file_path
    end

    -- 关闭浮动窗口
    local function close_float_window()
        if close_timer then
            pcall(function() close_timer:close() end)
            close_timer = nil
        end

        if float_win and vim.api.nvim_win_is_valid(float_win) then
            pcall(vim.api.nvim_win_close, float_win, true)
        end

        if float_buf and vim.api.nvim_buf_is_valid(float_buf) then
            pcall(vim.api.nvim_buf_delete, float_buf, { force = true })
        end

        float_win = nil
        float_buf = nil
        is_switching = false -- 重置切换状态
    end

    -- 重置关闭计时器（连续切换时调用）
    local function reset_close_timer()
        if close_timer then
            pcall(function() close_timer:close() end)
            close_timer = nil
        end

        -- 只有在浮窗存在时才设置新的计时器
        if float_win and vim.api.nvim_win_is_valid(float_win) then
            close_timer = vim.defer_fn(close_float_window, 800) -- 0.8秒后关闭
        end
    end

    -- 创建或更新浮动窗口
    local function create_or_update_float_window()
        -- 如果浮窗不存在，创建新窗口
        if not float_win or not vim.api.nvim_win_is_valid(float_win) then
            close_float_window() -- 确保完全清理

            if #recent_buffers < 2 then return end

            -- 创建新缓冲区
            float_buf = vim.api.nvim_create_buf(false, true)
            local width = 60
            local height = math.min((#recent_buffers + 3), 12)

            -- 计算居中位置
            local ui = vim.api.nvim_list_uis()[1]
            local col = math.floor((ui.width - width) / 2)
            local row = math.floor((ui.height - height) / 2)

            -- 创建新窗口
            float_win = vim.api.nvim_open_win(float_buf, false, {
                relative = "editor",
                width = width,
                height = height,
                col = col,
                row = row,
                style = "minimal",
                border = "rounded",
                title = "Recent Buffers (Ctrl+n)",
                title_pos = "center"
            })

            vim.api.nvim_win_set_option(float_win, "winhl", "Normal:NormalFloat,FloatBorder:FloatBorder")
        end

        -- 更新显示内容（按访问时间排序，列表顺序保持不变）
        if float_buf and vim.api.nvim_buf_is_valid(float_buf) then
            local lines = { "Recent Buffers (Most Recent First):", "" }
            local highlights = {}
            for i, buf in ipairs(recent_buffers) do
                local display_name, file_path = get_buffer_display_info(buf)
                local indicator = i == current_index and "▶ " or "  "
                local line_num = #lines

                -- 添加序号和文件名
                local line_content = string.format("%s%2d. %s", indicator, i, display_name)
                table.insert(lines, line_content)
                -- 为选中的条目设置高亮
                if i == current_index then
                    -- 整个行背景高亮
                    table.insert(highlights, { "Visual", line_num, 0, -1 })
                    -- 指示器高亮
                    table.insert(highlights, { "Special", line_num, 0, 2 })
                    -- 序号高亮
                    table.insert(highlights, { "Number", line_num, 2, 5 })
                    -- 文件名高亮
                    table.insert(highlights, { "Bold", line_num, 5, -1 })
                else
                    -- 非选中条目的指示器
                    table.insert(highlights, { "Comment", line_num, 0, 2 })
                    -- 非选中条目的序号
                    table.insert(highlights, { "LineNr", line_num, 2, 5 })
                end
            end

            -- 安全更新缓冲区内容
            pcall(function()
                vim.api.nvim_buf_set_option(float_buf, "modifiable", true)
                vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, lines)
                vim.api.nvim_buf_set_option(float_buf, "modifiable", false)

                -- 清除并重新设置高亮
                vim.api.nvim_buf_clear_namespace(float_buf, -1, 0, -1)

                -- 高亮当前选中的行
                local line_offset = 2 -- 前两行是标题
                for _, hl in ipairs(highlights) do
                    vim.api.nvim_buf_add_highlight(float_buf, -1, hl[1], hl[2], hl[3], hl[4])
                end
            end)
        end

        -- 重置关闭计时器
        reset_close_timer()
        is_switching = true -- 标记为正在切换

        return float_win, float_buf
    end

    -- 主切换函数
    vim.keymap.set("n", "<C-n>", function()
        local current_time = vim.loop.now()
        local time_diff = current_time - last_time

        update_recent_buffers()

        if #recent_buffers < 2 then
            vim.notify("No other buffers", vim.log.levels.INFO)
            close_float_window()
            return
        end

        local target_buf

        current_index = (current_index % #recent_buffers) + 1
        target_buf = recent_buffers[current_index]

        -- 执行切换
        vim.cmd("buffer " .. target_buf)

        -- 重要：切换后不更新最近访问列表，保持列表顺序不变
        -- 只更新当前索引，因为我们已经切换到了目标缓冲区
        -- 不需要重新排序 recent_buffers

        -- 创建或更新浮动窗口（连续切换时不会关闭）
        create_or_update_float_window()

        last_time = current_time
    end, { silent = true, desc = "Switch recent buffers with floating window" })

    -- 只在真正切换缓冲区时才更新最近访问列表
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        callback = function()
            -- 只有在非连续切换状态下才更新列表
            if not is_switching then
                local current_buf = vim.api.nvim_get_current_buf()
                local valid_buffers = vim.tbl_filter(function(buf)
                    return vim.api.nvim_buf_is_valid(buf) and
                        vim.api.nvim_buf_get_option(buf, 'buflisted') and
                        vim.api.nvim_buf_is_loaded(buf) and
                        vim.bo[buf].buftype == ""
                end, vim.api.nvim_list_bufs())

                -- 如果当前缓冲区不在列表中，添加到开头
                if not vim.tbl_contains(recent_buffers, current_buf) then
                    table.insert(recent_buffers, 1, current_buf)
                else
                    -- 如果已经在列表中，移动到最前面（最近访问）
                    recent_buffers = vim.tbl_filter(function(buf)
                        return buf ~= current_buf
                    end, recent_buffers)
                    table.insert(recent_buffers, 1, current_buf)
                end

                -- 确保所有有效缓冲区都在列表中
                for _, buf in ipairs(valid_buffers) do
                    if not vim.tbl_contains(recent_buffers, buf) then
                        table.insert(recent_buffers, buf)
                    end
                end

                -- 移除无效缓冲区
                recent_buffers = vim.tbl_filter(function(buf)
                    return vim.tbl_contains(valid_buffers, buf)
                end, recent_buffers)

                -- 限制列表长度，只保留最近使用的
                if #recent_buffers > 10 then
                    recent_buffers = { unpack(recent_buffers, 1, 10) }
                end

                -- 更新当前索引
                for i, buf in ipairs(recent_buffers) do
                    if buf == current_buf then
                        current_index = i
                        break
                    end
                end
            end
        end
    })

    -- 监听模式变化来关闭弹窗（只在非连续切换状态下）
    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*",
        callback = function()
            if not is_switching and float_win and vim.api.nvim_win_is_valid(float_win) then
                close_float_window()
            end
        end
    })

    -- 监听光标移动来关闭弹窗（只在非连续切换状态下）
    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
            if not is_switching and float_win and vim.api.nvim_win_is_valid(float_win) then
                close_float_window()
            end
        end
    })

    -- 手动关闭
    vim.keymap.set("n", "<Esc>", close_float_window, { silent = true })

    -- 初始更新
    update_recent_buffers()
end

setup_ctrl_n_switcher()
