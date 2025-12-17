local vim = vim
local status, telescope = pcall(require, "telescope")
if not status then
    return vim.notify("没有找到 telescope")
end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>f', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('v', '<leader>g', function()
    vim.cmd('noautocmd normal! "zy')
    local text = vim.fn.getreg('z')
    if text and text ~= '' then
        print("选中的文本: " .. text)
        require('telescope.builtin').grep_string({
            -- default_text = text,
            search = text,
            use_regex = false,
        })
    else
        print("没有选中文本")
    end
end, { desc = '搜索选中内容' })

vim.keymap.set('n', '<C-m>', function()
    -- 使用 lsp 查找文件符号
    builtin.lsp_document_symbols({
        symbol_width = 50,
        show_line = true,
        bufnr = vim.api.nvim_get_current_buf(),
        remaining = true,
        symbols = {"function", "method"}
    })
end, { desc = "Treesitter 符号查找" })

telescope.setup({
    defaults = {
        mappings = {
            i = {

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                -- 其他常用映射
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-c>"] = actions.close,
                ["<C-w>"] = actions.close,
                ["<Esc>"] = actions.close,

                -- 保持原有的 j/k 映射（如果需要）
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
            },
            n = {
                -- 正常模式下的映射
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
        layout_strategy = "vertical",
        layout_config = {
            vertical = {
                height = 0.95,
                preview_cutoff = 1,
                width = 0.95,
                preview_width = 0.95,
                show_line = true,
            },
        },
    },
})
