安装neovim

* 安装依赖：sudo yum -y install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch gettext curl

* git clone https://github.com/neovim/neovim
* cd neovim && sudo make
* sudo make install
* 支持python3：sudo pip3 install --upgrade pynvim

vim插件

插件管理Plug

* 安装：curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

主题插件nerodark.vim

目录树插件nerdtree

* , + t：打开目录树

状态栏插件vim-airline

启动界面插件vim-startify

缩进可视化插件indentLine

代码注释插件vim-commentary

* ctrl + v选中行，/进行注释

快速跳转插件vim-easymotion

* ss + 跳转地方的两个字符：快速跳转

代码高亮插件vim-interestingwords

* ctrl + k：高亮单词
* ctrl + j：取消全部高亮

文件搜索，模糊搜索插件leaderF

* 安装rg
  * 安装yum的扩展包：yum install yum-utils -y
  * 设置yum源：sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
  * 安装：sudo yum install ripgrep

* ctrl + p：模糊搜索文件
* ctrl + n：文件函数搜索
* ctrl + m：打开最近访问文件列表
* 选中单词 + , + g：全局搜索

tmux状态栏插件tmuxline.vim

代码补全插件ncm2

终端复用tmux

* 安装：sudo yum -y install tmux
