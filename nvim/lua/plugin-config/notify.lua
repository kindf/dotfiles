-- 如果找不到notify 组件，就不继续执行
local status, notify = pcall(require, "notify")
if not status then
    return vim.notify("没有找到 notify")
end

-- :h notify.Config
local opts = {
    level = 0,
}

notify.setup(opts)
vim.notify = notify


-- lspsaga
local lspsaga = require("lspsaga")
lspsaga.setup()
