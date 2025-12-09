-- 如果找不到lualine 组件，就不继续执行
local vim = vim
local status, comment = pcall(require, "Comment")
if not status then
    return vim.notify("没有找到 comment")
end
-- 快速备注
comment.setup(
    {
        toggler = {
            line = "cc",
        },
        opleader = {
            line = "cc",
        },

        mappings = {
            basic = true,
            extra = true,
        },
    }
)
