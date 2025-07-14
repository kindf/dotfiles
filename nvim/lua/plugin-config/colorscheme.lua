local ok, theme = pcall(require, "ayu")
if not ok then
    vim.notify("colorstheme " .. ayu .. " 没有找到！")
    return
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
        Comment = { fg = '#5C6773', italic = true }, -- 注释斜体

        -- LSP 诊断样式
        DiagnosticError = { fg = '#FF3333' },
        DiagnosticWarn = { fg = '#FF8F40' },

        -- 状态栏优化
        StatusLine = { bg = '#0A0E14', fg = '#E6B450' },
    },
})

local colorscheme = "ayu"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorstheme " .. colorscheme .. " 没有找到！")
    return
end

-- 行号高亮设置
vim.api.nvim_set_hl(0, "LineNr", {
  -- fg = "#FF9E64",          -- 行号文字颜色（橙色）
  fg = "#FFD700",          -- 行号文字颜色（橙色）
  bold = true,             -- 加粗
  bg = "#161C21"
})

-- 当前行号特殊高亮
vim.api.nvim_set_hl(0, "CursorLineNr", {
  fg = "#FFD700",          -- 金色当前行号
  bold = true,
  bg = "#161C21"
})

