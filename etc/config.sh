# shell prompt
# from vim ":PromptlineSnapshot ~/.dotfiles/bin/shell_prompt.sh airline"
if [ -f "$HOME/.config/dotfiles/bin/shell_prompt.sh" ]; then
    source $HOME/.config/dotfiles/bin/shell_prompt.sh
fi

# enable bash completion
# yum install bash-completion
[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion ]] && \
    . /usr/local/share/bash-completion/bash_completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# for tmux
export TERM=xterm-256color
export TERM_ITALICS=true

# editor
if command -v nvim > /dev/null 2>&1; then
    # alias vim=nvim
    export VISUAL=nvim
else
    export VISUAL=vim
fi
export EDITOR="$VISUAL"

alias svn=svn-color.py
export HISTTIMEFORMAT="%d/%m/%y %T "

# set pwd for tmux
function set_tmux_pwd() {
    [ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD"
    return 0
}
function my_cd() {
    \cd $1
    set_tmux_pwd
}
set_tmux_pwd
alias cd=my_cd


alias l='ls -ClF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
