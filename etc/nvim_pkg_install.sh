#!/usr/bin/bash

# pkg安装neovim(~/.dotfiles/pkg)

PROJECT_PATH=~/.dotfiles
PKG_PATH=${PROJECT_PATH}/pkg
mkdir -p ${PKG_PATH}
cd ${PKG_PATH}

VERSION=0.7.2
PKG_NAME=nvim-linux64.tar.gz
if [ ! -f ${PKG_NAME} ]; then
    wget -O ${PKG_NAME} https://github.com/neovim/neovim/releases/download/v${VERSION}/${PKG_NAME}
    tar -zxvf ${PKG_NAME}
fi

cd nvim-linux64
ln -s ${PKG_PATH}/nvim-linux64/bin/nvim ${PROJECT_PATH}/bin/nvim
cd ../..
