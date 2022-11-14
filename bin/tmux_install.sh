#!/usr/bin/bash

# 构建所需包
build_libs=(libevent-devel ncurses-devel gcc make bison pkg-config)

# 运行所需包
run_libs=(libevent ncurses)

install_libs=()

# 检查构建所需包
for lib in ${build_libs[@]}
do
    if ! rpm -q $lib &>/dev/null; then
        install_libs+=($lib)
    fi
done

# 检查安装所需包
for lib in ${run_libs[@]}
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

version=2.7
pkg_name=tmux-${version}.tar.gz

if [ ! -f ${pkg_name} ]; then
    wget -O ${pkg_name} https://github.com/tmux/tmux/releases/download/${version}/${pkg_name}
    tar -zxf ${pkg_name}
fi

cd tmux-${version}/
./configure
make && sudo make install

cd ../..
