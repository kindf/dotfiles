-- 如果找不到lualine 组件，就不继续执行
local status, lualine = pcall(require, "lualine")
if not status then
    vim.notify("没有找到 lualine")
    return
end

lualine.setup({
    options = {
        theme = "ayu",
        component_separators = { left = "|", right = "|" },
        -- https://github.com/ryanoasis/powerline-extra-symbols
        section_separators = { left = " ", right = "" },
    },
    extensions = { "nvim-tree", "toggleterm" },
    sections = {
        lualine_a = {
            {
                'filename',
                file_status = true, -- Displays file status (readonly status, modified status)
                newfile_status = false, -- Display new file status (new file means no write after created)
                path = 1, -- 0: Just the filename
                symbols = {
                    modified = '[+]', -- Text to show when the file is modified.
                    readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                    newfile = '[New]', -- Text to show for new created file before first writting
                },
            },
        },
        lualine_b = {
            "mode",
        },
        lualine_c = {
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = 'ERROR:', warn = 'WARN:', info = 'INFO:', hint = 'HINT:' },
                colored = true,
                always_visible = true
            }
        },
        lualine_x = {
            "filesize",
            {
                "fileformat",
                -- symbols = {
                --   unix = '', -- e712
                --   dos = '', -- e70f
                --   mac = '', -- e711
                -- },
                symbols = {
                    unix = "LF",
                    dos = "CRLF",
                    mac = "CR",
                },
            },
            "encoding",
            "filetype",
        },
    },
})
-- 或者自定义状态栏函数
function ShowDiagnostics()
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    if errors > 0 or warnings > 0 then
        return string.format(' %d  %d  %d  %d', errors, warnings, info, hints)
    else
        return '✓'
    end
end

vim.opt.statusline = '%f %h%w%m%r ' .. '%#ErrorMsg#' .. '%{v:lua.ShowDiagnostics()}' .. '%*' .. ' %= %l,%c%V %P'
