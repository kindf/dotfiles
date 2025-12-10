
local vim = vim
local status, spectre = pcall(require, "spectre")
if not status then
    return vim.notify("没有找到 spectre")
end

spectre.setup({
    color_devicons = true,
    open_cmd       = "vnew",
    live_update    = true, -- 实时更新搜索结果
    line_sep_start = "┌-----------------------------------------",
    result_padding = "¦  ",
    line_sep       = "└-----------------------------------------",
    highlight      = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete",
    },
    mapping        = {
        ["toggle_line"] = {
            map = "dd",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "toggle current item",
        },
        ["enter_file"] = {
            map = "<cr>",
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = "goto current file",
        },
        ["send_to_qf"] = {
            map = "<leader>q",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all item to quickfix",
        },
        ["replace_cmd"] = {
            map = "<leader>c",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "input replace vim command",
        },
        ["show_option_menu"] = {
            map = "<leader>o",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "show option",
        },
        ["run_current_replace"] = {
            map = "r",
            cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
            desc = "replace current line",
        },
        ["run_replace"] = {
            map = "R",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "replace all",
        },
        ["change_view_mode"] = {
            map = "<leader>v",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "change result view mode",
        },
    },
})

-- -- 配置键位
vim.keymap.set("n", "<leader>sr", function()
    -- 获取可视选择的内容
    local saved_unnamed_register = vim.fn.getreg('"')
    vim.cmd('normal! "xy')
    local selected_text = vim.fn.getreg('x')
    vim.fn.setreg('"', saved_unnamed_register)

    require("spectre").open({
        search_text = selected_text,
        path = vim.api.nvim_buf_get_name(0):match("([^/\\]+)$"),     -- 当前文件的完整路径
        is_file = true,                                              -- 限制在当前文件
    })
end, { desc = "Replace in files (Spectre)" })

vim.keymap.set("n", "<leader>ss", function()
    require("spectre").open_visual({ 
        select_word = true,
        path = vim.api.nvim_buf_get_name(0):match("([^/\\]+)$"),     -- 当前文件的完整路径
    })
end, { desc = "Search current word" })
