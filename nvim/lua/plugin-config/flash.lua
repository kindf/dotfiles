local vim = vim
local status, flash = pcall(require, "flash")
if not status then
    return vim.notify("没有找到 flash")
end
flash.setup({
    label = {
        min_pattern_length = 1,
        uppercase = true,
    },
    -- 自定义键位
    modes = {
        char = {
            jump_labels = true,
            -- enabled = false, -- 禁用 char 模式
            char_actions = function(motion)
                return {
                    [";"] = "next", -- 重复上一次跳转
                    [","] = "prev", -- 反向重复
                }
            end,
            keys = {},
        },
        -- 树状标签模式
        treesitter = {
            labels = "abcdefghijklmnopqrstuvwxyz",
            jump = { pos = "range" },
            search = { incremental = false },
            label = { before = true, after = true, style = "inline" },
        },
    },

    -- 远程操作（跨窗口）
    remote_op = {
        restore = true, -- 跳转后恢复原始窗口
        motion = true,  -- 支持动作命令
    },

    -- 排除文件类型
    exclude = {
        "notify",
        "cmp_menu",
        "noice",
        "flash_prompt",
    },

    -- 自动跳转
    autojump = {
        enabled = true,
        override = function()
            -- 自定义自动跳转逻辑
            return false
        end,
    },

    -- 高亮组
    highlight = {
        backdrop = false, -- 背景变暗
        matches = true,   -- 高亮匹配
        groups = {
            match = "FlashMatch",
            current = "FlashCurrent",
            backdrop = "FlashBackdrop",
            label = "FlashLabel",
        },
    },
})

-- 添加到你的 keymaps 配置中
vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump({
        search = {
            mode = function(str)
                return str
            end,
        },
    })
end, { desc = "Flash" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
    require("flash").treesitter({
    })
end, { desc = "flash treesitter" })

