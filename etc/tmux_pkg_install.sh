#!/usr/bin/bash

# 构建所需包
BUILD_LIBS=(libevent-devel ncurses-devel gcc make bison pkg-config)

# 运行所需包
RUN_LIBS=(libevent ncurses)

install_libs=()

# 检查构建所需包
for lib in ${BUILD_LIBS[@]}
do
    if ! rpm -q $lib &>/dev/null; then
        install_libs+=($lib)
    fi
done

# 检查安装所需包
for lib in ${RUN_LIBS[@]}
do
    if ! rpm -q $lib &>/dev/null; then
        install_libs+=($lib)
    fi
done

# 安装欠缺包
if [ ${#install_libs[@]} -gt 0 ]; then
    echo -e "\033[32m start install ${install_libs}\n \033[0m"
    sudo yum -y install ${install_libs}
fi

# 安装tmux
mkdir -p pkg
cd pkg

VERSION=2.7
PKG_NAME=tmux-${VERSION}.tar.gz

if [ ! -f ${PKG_NAME} ]; then
    wget -O ${PKG_NAME} https://github.com/tmux/tmux/releases/download/${VERSION}/${PKG_NAME}
    tar -zxf ${PKG_NAME}
fi

cd tmux-${VERSION}/
./configure
make && sudo make install

cd ../..
