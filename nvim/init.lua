require('basic')
require('keybindings')
require('plugins')
-- lsp 相关
require('plugin-config.lspsaga')
require('lsp.setup')
require('lsp.cmp')
-- 主题
require('plugin-config.colorscheme')
-- 状态栏显示
require('plugin-config.lualine')
-- 会话保存
require('plugin-config.autosession')
-- 页签管理
require('plugin-config.bufferline')
-- 模糊搜索
require('plugin-config.telescope')
-- 快速跳转
require('plugin-config.flash')
-- 快速备注
require('plugin-config.comment')
-- 快速替换
require('plugin-config.spectre')
-- 浮动终端管理器
require('plugin-config.fterm')
-- 诊断信息
require('plugin-config.tiny-inline-diagnostic')
-- 分割线
require('plugin-config.indent-blankline')
-- 系统剪贴板
require('plugin-config.vim-oscyank')
-- 快捷键实现
require('plugin-config.tab_switch')
