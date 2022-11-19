#!/usr/bin/bash

# pkg安装python3.7(~/.dotfiles/pkg)
set -e
set -x

PROJECT_PATH=~/.dotfiles
PKG_PATH=${PROJECT_PATH}/pkg
mkdir -p ${PKG_PATH}
cd ${PKG_PATH}

VERSION=3.7.4
PKG_NAME=Python-${VERSION}.tgz
if [ ! -f ${PKG_NAME} ]; then
    wget -O ${PKG_NAME} https://www.python.org/ftp/python/${VERSION}/${PKG_NAME}
    tar -zxvf ${PKG_NAME}
fi

INSTALL_PATN=${PKG_PATH}/Python-${VERSION}/
cd ${INSTALL_PATN}
./configure --prefix=${INSTALL_PATN}
make

# 支持pip
if [ ! -f "get-pip.py" ]; then
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
fi

./python get-pip.py
./python -m pip install pynvim

CUR_PATH=`pwd`
ln -s ${CUR_PATH}/python ${PROJECT_PATH}/bin/python

cd ../..
