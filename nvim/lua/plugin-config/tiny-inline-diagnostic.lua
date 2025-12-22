local vim = vim
local status, diagnostic = pcall(require, "tiny-inline-diagnostic")
if not status then
    return vim.notify("没有找到 tiny-inline-diagnostic")
end

diagnostic.setup({
    options = {
        multilines = {
            enabled = true, -- 多行显示
            always_show = true, --总是显示诊断信息
        },
        show_source = {
            enabled = true, -- 显示诊断信息的来源
        },
        set_arrow_to_diag_color = true, -- 箭头使用诊断信息的颜色
    },
})

