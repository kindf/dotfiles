#! /usr/bin/bash

set -e
set -x

PROJECT_PATH=~/.dotfiles
ETC=$PROJECT_PATH/etc
BIN=$PROJECT_PATH/bin

# 克隆/更新项目
if [ -d $PROJECT_PATH ]; then
    cd $PROJECT_PATH
    git pull
else
    git clone https://github.com/kindf/dotfiles.git $PROJECT_PATH
    cd $PROJECT_PATH
fi

# 引入init.sh
sed -i "\:$ETC/init.sh:d" ~/.bashrc
echo ". $ETC/init.sh" >> ~/.bashrc
. ~/.bashrc

# 安装vim插件管理器
mkdir -p ~/.vim/autoload
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# 安装neovim
if [ ! $(command -v nvim) ]; then
    echo -e "\033[32m start install neovim\n \033[0m"
    sudo yum -y install neovim
    # sudo pip3 install --upgrade pynvim
fi
# \vim +PlugInstall +qall
nvim --headless +PlugInstall +qall
# echo -e "\033[32m install nvim end \n \033[0m"

# 引入vimrc.vim
touch ~/.vimrc
sed -i "\:$ETC/vimrc.vim:d" ~/.vimrc
echo "source $ETC/vimrc.vim" >> ~/.vimrc

# nvim配置
NVIM_CONFIG_PATH=~/.config/nvim
mkdir -p $NVIM_CONFIG_PATH
cp $ETC/init.vim $NVIM_CONFIG_PATH/init.vim


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
