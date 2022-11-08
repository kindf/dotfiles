# 交互式模式的初始化脚本
# 防止被加载两次

if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

# 如果是非交互式则退出，比如 bash test.sh 这种调用 bash 运行脚本时就不是交互式
# 只有直接敲 bash 进入的等待用户输入命令的那种模式才成为交互式，才往下初始化
case "$-" in
    *i*) ;;
    *) return
esac

# 将个人 ~/.dotfiles/bin 目录加入 PATH
_ADD_PATH=`echo -e "$PATH" | grep "$HOME/\.dotfiles/bin"` 
if [ -d "$HOME/.dotfiles/bin" ] && [ -z $_ADD_PATH ]; then
    export PATH="$HOME/.dotfiles/bin:$PATH"
fi

# 判断 ~/.dotfiles/etc/config.sh 存在的话，就 source 它一下
if [ -f "$HOME/.dotfiles/etc/config.sh" ]; then
    . "$HOME/.dotfiles/etc/config.sh"
fi

# 如果是登陆模式，那么 source 一下 ~/.dotfiles/etc/login.sh
if [ -n "$BASH_VERSION" ]; then
    if shopt -q login_shell; then
        if [ -f "$HOME/.dotfiles/etc/login.sh" ] && [ -z "$_INIT_SH_NOLOG" ]; then
            . "$HOME/.dotfiles/etc/login.sh"
        fi
    fi
fi

