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

# 将个人 ~/.local/bin 目录加入 PATH
_ADD_PATH=`echo -e "$PATH" | grep "$HOME/\.local/bin"` 
if [ -d "$HOME/.local/bin" ] && [ -z $_ADD_PATH ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# 判断 ~/.local/etc/config.sh 存在的话，就 source 它一下
if [ -f "$HOME/.local/etc/config.sh" ]; then
    . "$HOME/.local/etc/config.sh"
fi

# 如果是登陆模式，那么 source 一下 ~/.local/etc/login.sh
if [ -n "$BASH_VERSION" ]; then
    if shopt -q login_shell; then
        if [ -f "$HOME/.local/etc/login.sh" ] && [ -z "$_INIT_SH_NOLOG" ]; then
            . "$HOME/.local/etc/login.sh"
        fi
    fi
fi

