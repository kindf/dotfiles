#! /usr/bin/bash

set -e
# set -x

PROJECT_PATH=~/.dotfiles
ETC=$(PROJECT_PATH)/etc
BIN=$(PROJECT_PATH)/bin

# 克隆/更新项目
if [ -d $PROJECT_PATH ]; then
    cd $PROJECT_PATH
    git pull
else
    git clone https://github.com/kindf/dotfiles.git ~/
    cd $PROJECT_PATH
fi

# 引入init.sh
sed -i "\:$ETC/init.sh:d" ~/.bashrc
echo ". $ETC/init.sh" >> ~/.bashrc
. ~/.bashrc

# 引入vimrc.vim
touch ~/.vimrc
sed -i "\:$ETC/vimrc.vim:d" ~/.vimrc
echo "source $ETC/vimrc.vim" >> ~/.vimrc

# 引入tmux.conf
touch ~/.tmux.conf
sed -i "\:$ETC/tmux.conf:d" ~/.tmux.conf
echo "source $ETC/tmux.conf" >> ~/.tmux.conf

# 安装vim插件管理器
mkdir -p ~/.vim/autoload
if [ ! -f "~/.vim/autoload/plug.vim" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# 安装neovim
if [ ! $(command -v nvim) ]; then
    echo "start install neovim\n"
    sudo yum -y install neovim
    # sudo pip3 install --upgrade pynvim
    \vim +PlugInstall +qall
fi

# 安装tmux
if [ ! $(command -v tmux) ]; then
    echo "start install tmux\n"
    sudo yum -y install tmux
fi

# 安装rg
if [ ! $(command -v rg) ]; then
    echo "start install rg\n"
    sudo yum -y install yum-utils
    sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    sudo yum -y install ripgrep
fi