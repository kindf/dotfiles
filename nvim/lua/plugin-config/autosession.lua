-- 如果找不到lualine 组件，就不继续执行
local status, auto_session = pcall(require, "auto-session")
if not status then
    vim.notify("没有找到 auto_session")
    return
end

local opts = {
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = nil,
  auto_session_use_git_branch = nil,
  -- the configs below are lua only
  bypass_session_save_file_types = nil
}

auto_session.setup(opts)
