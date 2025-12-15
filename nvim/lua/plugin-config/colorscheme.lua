local ok, theme = pcall(require, "ayu")
local vim = vim
if not ok then
    return vim.notify("theme 没有找到！")
end

theme.setup({
    mirage = true,
    overrides = {
    -- 自定义高亮组（覆盖默认）
        -- Normal = { bg = '#0A0E14' },                 -- 深化背景
        Normal = { bg = '#1A1F27' },                 -- 深化背景
        NormalNC = {bg = '#f0f0f0', fg = '#808080'},
        LineNr = { fg = '#FFD700', bold = true },    -- 行号样式
        CursorLineNr = { fg = '#FFD700', bold = true },    -- 行号样式
        -- LineNr = { fg = '#5C6773', bold = true },    -- 行号样式
        Comment = { fg = '#5C6773', italic = false }, -- 注释斜体

        -- LSP 诊断样式
        DiagnosticError = { fg = '#FF3333' },
        DiagnosticWarn = { fg = '#FF8F40' },

        -- 状态栏优化
        StatusLine = { bg = '#0A0E14', fg = '#E6B450' },
    },
})

local colorscheme = "ayu-mirage"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorstheme " .. colorscheme .. " 没有找到！")
    return
end

-- 行号高亮设置
vim.api.nvim_set_hl(0, "LineNr", {
  -- fg = "#FF9E64",          -- 行号文字颜色（橙色）
  fg = "#9E9E9E",          -- 行号文字颜色（橙色）
  bold = true,             -- 加粗
  bg = nil
})

-- 当前行号特殊高亮
vim.api.nvim_set_hl(0, "CursorLineNr", {
  fg = "#FFFFFF",          -- 金色当前行号
  bold = true,
  bg = "#161C21"
})

-- 非活动窗口的背景/文字颜色
vim.api.nvim_set_hl(0, 'NormalNC', {
  fg = '#BFBDB6',  -- 非活动窗口文字颜色
  bg = '#232A36'   -- 非活动窗口背景色（比主背景稍浅）
})

-- 非活动窗口的分割线颜色
vim.api.nvim_set_hl(0, 'WinSeparator', {
  fg = '#5C6773',  -- 分割线颜色
  bg = '#232A36'   -- 与非活动窗口背景一致
})
