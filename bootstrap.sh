#! /usr/bin/bash

set -e
set -x

PROJECT_PATH=~/.config/dotfiles
ETC=$PROJECT_PATH/etc
BIN=$PROJECT_PATH/bin
NVIM_CONFIG_PATH=~/.config/nvim

# 克隆/更新项目
if [ -d $PROJECT_PATH ]; then
    cd $PROJECT_PATH
    git pull
else
    git clone https://github.com/kindf/dotfiles.git $PROJECT_PATH
    cd $PROJECT_PATH
fi

# nvim配置
# cp -r $PROJECT_PATH/nvim $NVIM_CONFIG_PATH
if [ ! -d $NVIM_CONFIG_PATH ]; then
    ln -s $PROJECT_PATH/nvim $NVIM_CONFIG_PATH
fi

# 引入init.sh
sed -i "\:$ETC/init.sh:d" ~/.bashrc
echo ". $ETC/init.sh" >> ~/.bashrc
. ~/.bashrc

# 安装neovim
if [ ! $(command -v nvim) ]; then
    echo -e "\033[32m start install neovim\n \033[0m"
    sudo yum -y install neovim
    sudo pip3 install --upgrade pynvim
fi

# nvim插件安装
nvim --headless +PackerSync +qall

# 安装tmux
if [ ! $(command -v tmux) ]; then
    echo -e "\033[32m start install tmux\n \033[0m"
    sudo yum -y install tmux
fi

# 引入tmux.conf
touch ~/.tmux.conf
sed -i "\:$ETC/tmux.conf:d" ~/.tmux.conf
echo "source $ETC/tmux.conf" >> ~/.tmux.conf

# 安装rg
if [ ! $(command -v rg) ]; then
    echo -e "\033[32m start install ripgrep\n \033[0m"
    sudo yum -y install yum-utils
    sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    sudo yum -y install ripgrep
fi
