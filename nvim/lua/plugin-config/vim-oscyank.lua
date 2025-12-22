local vim = vim

vim.g.oscyank_silent = true -- 不显示提示
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        -- 只在普通模式和可视模式下生效
        local mode = vim.api.nvim_get_mode().mode
        if mode == 'n' or mode == 'v' or mode == 'V' then
            if vim.v.event.operator == 'y' then
                -- 延迟一点点确保 yank 完成
                vim.defer_fn(function()
                    vim.cmd('OSCYankReg "')
                end, 20)
            end
        end
    end
})

-- 让 p 从系统剪贴板粘贴（SSH 环境需要）
-- 如果是 SSH 连接
if vim.env.SSH_CONNECTION then
    vim.keymap.set({ 'n', 'v' }, 'p', '"+p')
    vim.keymap.set({ 'n', 'v' }, 'P', '"+P')
else
    -- 本地环境直接设置
    vim.opt.clipboard = 'unnamedplus'
end
-- 专门映射 yy
vim.keymap.set('n', 'yy', function()
    -- 先执行默认的 yy
    vim.cmd('normal! yy')
    -- 复制到系统剪贴板
    vim.cmd('OSCYankReg "')
end, { remap = false, desc = '复制行到系统剪贴板' })

-- 专门映射 dd
vim.keymap.set('n', 'dd', function()
    -- 先执行默认的 dd
    vim.cmd('normal! dd')
    -- 复制到系统剪贴板
    vim.cmd('OSCYankReg "')
end, { remap = false, desc = '复制行到系统剪贴板' })

-- 专门映射 d
vim.keymap.set('v', 'd', function()
    -- 先执行默认的 dd
    vim.cmd('normal! d')
    -- 复制到系统剪贴板
    vim.cmd('OSCYankReg "')
end, { remap = false, desc = '复制行到系统剪贴板' })
