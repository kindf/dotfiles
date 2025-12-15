local vim = vim
local status, _ = pcall(require, "FTerm")
if not status then
    return vim.notify("没有找到 FTerm")
end

-- fterm.setup()
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
