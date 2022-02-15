call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'                                          " 目录树
Plug 'KeitaNakamura/neodark.vim'                                    " vim主题
Plug 'mhinz/vim-startify'                                           " 启动界面
Plug 'vim-airline/vim-airline'                                      " vim状态栏
Plug 'edkolev/tmuxline.vim'                                         " tmux状态栏
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension' }       " 模糊搜索
Plug 'edkolev/promptline.vim'                                       " 生成 bash path color
Plug 'Yggdroot/indentLine'                                          " 缩进可视化
Plug 'easymotion/vim-easymotion'                                    " 快速跳转
Plug 'tpope/vim-commentary'                                         " 代码注释插件

Plug 'roxma/nvim-yarp'                                              " for ncm2
Plug 'ncm2/ncm2'                                                    " 自动补全
Plug 'ncm2/ncm2-path'                                               " ncm2路径补全

call plug#end()

"{{ 通用配置
set nocompatible
set ai                                  "自动缩进
set si
set bs=2                                "在insert模式下用退格键删除
set showmatch                           "代码匹配
"设置tab和缩进空格数
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set cursorline                          "为光标所在行加下划线
set cursorcolumn                        "为光标所在行加下划线
set number                              "显示行号
set autoread                            "文件在Vim之外修改过，自动重新读入
set autowriteall                        "设置自动保存
set ignorecase                          "检索时忽略大小写
set encoding=utf-8
set fileencoding=utf-8                  "使用utf-8新建文件
set fileencodings=utf-8,gbk             "使用utf-8或gbk打开文件
let &termencoding=&encoding
set hls                                 "检索时高亮显示匹配项
set helplang=cn                         "帮助系统设置为中文
set nofoldenable                        "关闭代码折叠
set clipboard=unnamed                   " use the system clipboard
set nois                                " 设置搜索不自动跳转
set noshowmode
set mouse=a                             " 支持鼠标滚动
set diffopt=vertical                    " diff 窗口纵排
set wildignore=*.swp,*.bak,*.pyc,*.obj,*.o,*.class
set wildignore+=*.so,*.swp,*.zip        " MacOSX/Linux
set wildignore+=*.exe                   " Windows
set tags=./.tags;,.tags
set ttimeout
set ttimeoutlen=100
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
"}} 通用配置结束

syn on
syn enable
set t_Co=256

let g:left_sep=""
let g:left_alt_sep=""
let g:right_sep=""
let g:right_alt_sep=""

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if (has("termguicolors"))
    set termguicolors
endif

colorscheme neodark

" config
set number
set wildignorecase
set wildmenu

" 快捷键
let mapleader = ','
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <C-s> :w<cr>
nnoremap <C-w> :q<cr>
nnoremap <C-q> :wqa<cr>
nnoremap <C-e> <C-w><C-w>
inoremap <A-j> <Esc>
inoremap <A-k> <Esc>
inoremap <A-l> <Esc>
inoremap <A-h> <Esc>
nnoremap <space> viw
map <C-k> <leader>k
" map <C-j> <leader>K
nmap <C-j> <Plug>(easymotion-s2)
vmap / gc

" airline
let g:airline#extensions#tabline#enabled = 1 
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tmuxline#enabled = 1

"promptline{
":PromptlineSnapshot! ~/.local/etc/shell_prompt.sh airline
let g:promptline_symbols = {
    \ 'left'          : g:left_sep,
    \ 'left_alt'      : g:left_alt_sep,
    \ 'right'         : g:right_sep,
    \ 'right_alt'     : g:right_alt_sep,
    \ 'dir_sep'       : " > ",
    \ 'truncation'    : "\u22EF",
    \ 'vcs_branch'    : "\u16A0 "}
if !empty(globpath(&rtp, "promptline.vim"))
    let g:promptline_preset = {
   \ 'a' : [ promptline#slices#user() ],
   \ 'c' : [ promptline#slices#cwd() ],
   \ 'y' : [ promptline#slices#vcs_branch() ]}
endif
let g:promptline_theme = 'airline'
"}


"tmuxline{                                                                                                                        291 ":Tmuxline airline
":TmuxlineSnapshot! ~/.local/etc/tmuxline.conf
let g:tmuxline_separators = {
    \ 'left'     : g:left_sep,
    \ 'left_alt' : g:left_alt_sep,
    \ 'right'    : g:right_sep,
    \ 'right_alt': g:right_alt_sep}
let g:tmuxline_preset = {
    \'a'    : '#S',
    \'c'    : ['#(whoami)', '#(uptime | cut -d " " -f 1,2,3)'],
    \'win'  : ['#I', '#W'],
    \'cwin' : ['#I', '#W', '#F'],
    \'y'    : '%Y-%m-%d',
    \'z'    : "#(ip -4 a| grep inet | awk '{print $2}' | grep -v '127.0.0.1' | head -1)"}

"}

" nerdtree
function! ToggleNERDTree()
	silent exe ':NERDTree '.expand('%:p:h')
endfunction
nnoremap <leader>t :call ToggleNERDTree()<CR>
let NERDTreeIgnore = ['\~$'. '\$.*$', '\.swp$', '\.pyc$', '#.\{-\}#$']
let s:ignore = ['.pb', '.xls', '.xlsx', '.mobi', '.mp4', '.mp3']

for s:extname in s:ignore
	let NERDTreeIgnore += [escape(s:extname, '.~$')]
endfor

" LeaderF
noremap <c-m> :LeaderfMru<cr>
noremap <c-n> :LeaderfFunction<cr>
let g:Lf_ShortcutF = '<c-p>'
noremap <leader>g :<C-U><C-R>=printf("Leaderf! rg -F -t c -t py -t lua -t go --nowrap --stayOpen -e %s ", leaderf#Rg#visual())<cr><cr>


"NCM2
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" gtags

function! ClosePluginWindow()
	cclose

	redir => message
		silent execute "ls!"
	redir END
	let l:buflist = split(message, '\n')
	for l:one in l:buflist
		let l:items = split(l:one, '"')
	if match(l:items[0], "u*a-") >= 0
		let l:bufid = matchstr(l:items[0], '\d\+')
		exe 'bd! '.l:bufid
	endif
	endfor
endfunction

map <C-C><C-C> :call ClosePluginWindow()<cr>
