# 安装
* neovim
  * 安装：sudo yum -y install neovim
  * 支持python3：sudo pip3 install --upgrade pynvim
* 插件管理Plug
  * 安装：curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
* rg
  * 安装yum的扩展包：yum install yum-utils -y
  * 设置yum源：sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
  * 安装：sudo yum install ripgrep
* 终端复用tmux(配置文件.tmux.conf)
  * 安装：sudo yum -y install tmux
  * 快捷键
    * ctrl + e + i：竖分屏
    * ctrl + e + o：横分屏
    * crtl + e + n：向前切换窗口
    * crtl + e + m：向后切换窗口
    * crtl + e + z：当前窗口最大化

# vim插件
  * 目录树插件nerdtree
    * , + t：打开目录树
  * 代码注释插件vim-commentary
    * ctrl + v选中行，/进行注释
  * 快速跳转插件vim-easymotion
    * ss + 跳转地方的两个字符：快速跳转
  * 文件搜索，模糊搜索插件leaderF
    * ctrl + p：模糊搜索文件
    * ctrl + n：文件函数搜索
    * ctrl + m：打开最近访问文件列表
    * 选中单词 + , + g：全局搜索
  * 有道词典翻译插件vim-youdao-translater
    * , + ff：翻译
    * 选中单词 + ctrl + t：翻译选中单词
  * 状态栏插件vim-airline
  * 启动界面插件vim-startify
  * 缩进可视化插件indentLine
  * 代码补全插件ncm2
  * 主题插件nerodark.vim
