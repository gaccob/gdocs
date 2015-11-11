set nocp
syntax on               "语法高亮"
colo desert
set nocompatible        "使用vim的键盘模式"
set filetype=c
set nu                  "设置行号"
set nobackup            "不需要备份"
set confirm             "未保存或者只读时，弹出确认"
set showcmd             "显示未完成命令"
set tabstop=4           "tab为4个空格"
set expandtab
set shiftwidth=4        "行交错"
set cindent             "c文件类型自动缩进"
set autoindent          "自动对齐"
set smartindent         "智能缩进"
set hlsearch            "高亮查找匹配"
set background=dark     "背景色"
set showmatch           "显示匹配"
set ruler               "右下角显示光标位置"
set noerrorbells        "不发出警告声"
set autochdir           "查找ctags"
set fileencoding=utf-8  "默认utf8编码"
set fileencodings=utf-8,gb2312,gbk
"set foldmethod=syntax   "折叠设置" 
set noignorecase        "不忽略大小写"
let &termencoding=&encoding

"默认关闭折叠"
set foldclose=all
"打开所有折叠"
nmap <F9> zR
"关闭所有折叠"
nmap <F10> zM 
"空格打开、关闭折叠"
nmap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

let NERDTreeIgnore=['\.o$', '\.d$', '\.swp$', '\.pyc$', '^cscope\.', '\.so$', '\.a$']
nmap <F2> :NERDTree <cr>

nmap <F3> :TlistToggle <cr>
nmap <F4> :% s/\s\+$//g <cr>

nmap <F5> :vertical resize +2 <cr>
nmap <F6> :vertical resize -2 <cr>
nmap <F7> :resize +2 <cr>
nmap <F8> :resize -2 <cr>

"生成ctags文件"
nmap <F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude=*boost* .<cr>

"生成cscope文件"
nmap <F12> :!cscope -bkq `find \`pwd\` -name "*.h" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.c" \| grep -v "boost"`<cr>

"自动查找tags文件"
function! AutoLoadCtags()
    let max = 5
    let dir = './'
    let i = 0
    let break = 0
    while isdirectory(dir) && i < max
        if filereadable(dir . 'tags')
            execute 'set tags =' . dir . 'tags'
            let break = 1
        endif
        if break == 1
            execute 'lcd ' . dir
            break
        endif
        let dir = dir . '../'
        let i = i + 1
    endwhile
endf

"自动查找cscope文件"
function! AutoLoadCscope()
    let max = 5
    let dir = './'
    let i = 0
    let break = 0
    while isdirectory(dir) && i < max
        if filereadable(dir . 'tags')
            execute 'cs add ' . dir . 'cscope.out'
            let break = 1
        endif
        if break == 1
            execute 'lcd ' . dir
            break
        endif
        let dir = dir . '../'
        let i = i + 1
    endwhile
endf

"设置taglist显示"
let NERDTreeWinSize=20
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口
let Tlist_Auto_Open = 1

"查找符号, symble"
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"查找定义"
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"查找调用目标的函数, caller"
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"查找本文件, file"
nmap <C-\>f :cs find f <C-R>=expand("<cword>")<CR><CR>
"查找包含本文件的文件, include"
nmap <C-\>i :cs find i <C-R>=expand("<cword>")<CR><CR>

autocmd BufNewFile,BufRead *.h,*.c,*.cpp,*.hpp,*.cc call AutoLoadCtags()
autocmd BufNewFile,BufRead *.h,*.c,*.cpp,*.hpp,*.cc call AutoLoadCscope()

function! AutoUtf8()
    set fileencoding=utf-8
endf
autocmd BufNewFile,BufRead *.h,*.c,*.cpp,*.hpp,*.cc,*.lua call AutoUtf8()

function! AutoFileType()
    set filetype=lua
endf
autocmd BufNewFile,BufRead *.lua.tmpl call AutoFileType()

