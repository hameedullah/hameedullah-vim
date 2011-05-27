"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~/.vimrc                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Hameedullah Khan                                      "
" Email: h@hameedullah.com                                      "
"                                                               "
" Version: 0.1                                                  "
"                                                               "
" Sources: Help taken from many sources and other vim hackers.  "
"          All the sources are specified with the vim tip/trick "
"                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible          " Because filetype detection doesn't work well in compatible mode

" Hightlight the ifs and buts
syntax on 

" Plugins and indentation based on the file type
filetype plugin indent on

" Need to find out about this
set ruler

""" Test these options and then enable only that suite my style.
"set autoread
"set completeopt=menu
"set display=lastline showbreak=>>>\
"set ignorecase smartcase infercase
"set incsearch
"set linebreak nojoinspaces
"set modeline
"set path=.,~/.vim/** suffixesadd=.vim
"set ruler
"set tabpagemax=25
"set tabstop=2 shiftwidth=2
"set tags=./.tags;

" Don't remember source of this, i think it was already in my .vimrc
" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :5000 : up to 5000 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:5000,%,n~/.viminfo

" omnicomplete from: http://vim.wikia.com/wiki/VimTip1386
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" this key mapping never worked for me
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' : "  
"    \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


"###########################
"##       PHP             ##
"###########################
" The php doc plugin
" source ~/.vim/php-doc.vim 
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR>

" run file with PHP CLI (CTRL-M)
:autocmd FileType php noremap <C-M> :w!<CR>:!/usr/bin/php %<CR>

" PHP parser check (CTRL-L)
:autocmd FileType php noremap <C-L> :!/usr/bin/php -l %<CR>

" Session.vim settings
":let g:session_autosave = 1
":let g:session_autoload = 1

" Taken from http://peterodding.com/code/vim/profile/vimrc
" Do use the currently active spell checking for completion though!
" (I love this feature :-)
set complete+=kspell


" disable tabs
set expandtab
set shiftwidth=4
set softtabstop=4

" highlt matches
set hlsearch


" Taken from http://peterodding.com/code/vim/profile/vimrc
" Make Vim open and close folded text as needed because I can't be bothered to
" do so myself and wouldn't use text folding at all if it wasn't automatic.
" set foldmethod=marker foldopen=all,insert foldclose=all
" Folding
set foldmethod=indent foldopen=all,insert foldclose=all
set foldlevel=1

" to reduce the number of buffers while using sessions
set ssop-=buffers

" Enable enhanced command line completion.
set wildmenu wildmode=list:full

" Ignore these filenames during enhanced command line completion.
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif " binary images
set wildignore+=*.luac " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files

" Automatic commands. {{{1

autocmd FileType c setlocal cms=/*%s*/
autocmd FileType gitcommit setlocal autoindent
autocmd FileType sh setlocal isfname-==
autocmd FileType sh,php setlocal textwidth=0
autocmd BufReadPost */etc/* setlocal textwidth=0
autocmd BufReadPost */var/log/* setlocal ft=messages
autocmd FileType messages setlocal nowrap nomodifiable nospell
autocmd SwapExists * let v:swapchoice = 'e'
autocmd BufReadPost ~/.vim-plugin-tool.conf setl ft=dosini nospell

" Automatically sort word lists and generate spell files.
autocmd BufWritePre */spell/*.add %sort i
autocmd BufWritePost */spell/*.add silent mkspell! %

" Enable completion dictionaries for PHP and Python buffers.
"autocmd FileType python set complete+=k~/.vim/dict/python " isk+=.,(
autocmd FileType php set complete+=k~/.vim/dict/PHP.dict
"autocmd FileType lua set complete+=k~/.vim/dict/lua

" Enable omni-completion in Python scripts.
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Hide # comment markers from folded text in Python scripts.
autocmd FileType python set commentstring=#%s

" PHP Autocomplete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
set ofu=syntaxcomplete#Complete


" Note, perl automatically sets foldmethod in the syntax file
autocmd Syntax c,cpp,vim,xml,html,xhtml,php,py setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

" You might also find this useful
" PHP Generated Code Highlights (HTML & SQL)                                              
let php_sql_query=1                                                                                        
let php_htmlInStrings=1

" My custom keymaps
nnoremap ;s :SaveSession <C-R>=ProjectName()<CR><CR>
nnoremap ;o :OpenSession <C-R>=ProjectName()<CR>
nnoremap ;c :CloseSession<CR>:q<CR>
nnoremap ;r :RestartSession<CR><CR>
nnoremap ;t :TlistToggle<CR><CR>


"nnoremap ;p :Project<CR>:r ~/.projects/<C-R>=ProjectName()<CR><CR>
nnoremap ;p :Project<CR><CR>


function! ProjectName()
    if exists("g:ProjectName")
        return g:ProjectName
    endif
endfunction
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)
let tlist_sql_settings = 'sql;P:package;t:table'
let tlist_ant_settings = 'ant;p:Project;r:Property;t:Target'
" --------------------
" Project
" --------------------
map <A-S-p> :Project<CR>
map <A-S-o> :Project<CR>:redraw<CR>/
nmap <silent> <F3> <Plug>ToggleProject
"let g:proj_window_width = 30
"let g:proj_window_increment = 150

" auto change directory from: http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | lcd %:p:h | endif

