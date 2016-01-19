" Modeline, Author and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~/.vimrc                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Hameedullah Khan                                      "
" Email: h@hameedullah.com                                      "
"                                                               "
" Version: 0.3                                                  "
"                                                               "
" Sources: Help taken from many sources and other vim hackers.  "
"          All the sources are specified with the vim tip/trick "
"          The idea to divide the vim in sections using markers "
"          is taken form spf13-vim                              "
"                                                               "
" Target:  Make the .vimrc which I can resrouce any time        "
"          Tips for target: au! function!                       "
"                                                               " 
" Disclaimer:                                                   "
"          Spf-13 is a very good project, but its an attempt to "
"          make vim an ide not hacker friendly just like other  "
"          IDEs avaiable. So, I just can't use it but will use  "
"          goot bits from spf-13                                "
"                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }

" Environment {
    " Compatibly {
        " We need to set nocompatible mode to stop Vim being compatible with vi
        " This also reset options when you resource your .vimrc
	if &compatible
            set nocompatible 
	endif
    " }
    
    " Windows Compatible {
    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier.
	if has('win32') || has('win64')
	    set runtimepath=$HOME\.vim,$VIM\vimfiles,$VIMRUNTIME,$VIM\vimfiles\after,$HOME\.vim\after
	endif
    " }
    
  " GUI Settings {
" GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T " remove the toolbar
        set lines=40 " 40 lines of text instead of 24,
        "set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
        if has('gui_macvim')
            set transparency=5 " Make the window slightly transparent
        endif
    else
"set term=builtin_ansi " Make arrow and other keys work
    endif
" }  

    " Modeline { "
        set modeline
    "}
   
    " Pathogen {
        " This is actually the cool idea to keep plugins in their own separate folder to have a cleaner .vim-directory
        " Giving it a try
        " Copying spf-13
        " The next two lines ensure that the ~/.vim/bundle/ system works
        runtime! bundle/vim-pathogen/autoload/pathogen.vim
        call pathogen#infect()
        call pathogen#helptags()
    " }
    
    " Color Scheme Loading Fix {
        " Taken from: http://dominique.pelle.free.fr/.vimrc.html
        " Unlet g:color_names to avoid loading color scheme several times
        " when sourcing ~/.virmc a second time. Several commands would trigger
        " sourcing color scheme :syntax on and :set t_Co=256 and of course
        " command :colorscheme itself.
        if has('eval') | unlet! g:colors_name | endif
    " }

    " File Type {
        " Vim should try to determine the file type
        " This will allow vim to enable auto-indenting and plugins for the
        " file type
        if has('autocmd')
            filetype indent plugin on
        endif
    " }

    " Syntax Highlighting {
        " Highlight the IFs and BUTs
        if has('syntax')
            syntax on
        endif
    " }

    " History {
        " Tell vim to remember certain things when we exit
        "  '10 : marks will be remembered for up to 10 previously edited files
        "  "100 : will save up to 100 lines for each register
        "  :5000 : up to 5000 lines of command-line history will be remembered
        "  % : saves and restores the buffer list
        "  n... : where to save the viminfo files
        " set viminfo='10,\"100,:5000,%,n~/.viminfo
        set history=1000
    " }

    " Search {
        " Incremental Search
        set incsearch

        " Highlight searches (use <C-L> to temporarily turn off highlighting; see the mapping of <C-L> below)
        set hlsearch

        " Use case insensitive search, except when using capital letters
        set ignorecase
        set smartcase
    " }
    
    " Security {
        " Autowrite unsaved buffers
        " Alternatives include using tabs or split windows instead of re-using the same
        " window for multiple buffers, and/or:
        " set confirm
        " set autowriteall

        " Disable mode line because of security risks and use the securemode
        " line script http://www.vim.org/scripts/script.php?script_id=1876
        " TODO: Check how both options work
        " set nomodeline
        
        " set backup

        " TODO: Find about cryptmethod
        " taken from: http://dominique.pelle.free.fr/.vimrc.html
        if exists('+cryptmethod') | set cryptmethod=blowfish | endif
    " }

    " Command Line Mods {
        " Better command-line completion
        set wildmenu
        set wildmode=list:full

        " Command line completion inteligently
        " Ignore these filenames during enhanced command line completion.
        set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
        set wildignore+=*.jpg,*.bmp,*.gif " binary images
        set wildignore+=*.luac " Lua byte code
        set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
        set wildignore+=*.pyc " Python byte code
        set wildignore+=*.spl " compiled spelling word lists
        set wildignore+=*.sw? " Vim swap files


        " Show partial commands in the last line of the screen
        set showcmd
    " }

    " Colors & Themes {
        " Pump up the Vim
        " Currenly using Mustang theme
        " TODO: Add other themes and theming support with out modifying .vimrc
        if has('gui_running')
            set background=dark
            colorscheme Mustang
        else
            set background=dark
            set t_Co=256
            colorscheme Mustang
        endif
    " }

" }

" Usability {
    " Almost all of them are taken from: http://vim.wikia.com/wiki/Example_vimrc
    " These are options that users frequently set in their .vimrc. Some of them
    " change Vim's behaviour in ways which deviate from the true Vi way, but
    " which are considered to add usability. Which, if any, of these options to
    " use is very much a personal preference, but they are harmless.


    " The hidden feature seems to be useful
    set hidden

    " Line wrapping
    set wrap
    set showbreak=+++

    " Set chars to show instead of eol, trailing spaces and non breakable spaces
    " tab is by default '^I' so we don't need to change it
    " until somethign else is required in place of tab
    " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    " :help listchars "
    set listchars=eol:$,trail:·,nbsp:·

    " Not sure
    " TODO: read more
    "set whichwrap+=<,>,[,]

    " TODO: Read more about cpoptions
    "set cpoptions=ces$

    " TODO: Check with this later
    "set autoread

    " Always put the new split window below the current one
    set splitbelow

    " taken from spf-13
    " saves and restore on mkview command
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility

    " Save & Restore view options that is folds, cursor
    " Taken from spf-13
    au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
    au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)


    " Allow backspacing over autoindent, line breaks and start of insert action
    set backspace=indent,eol,start

    " When opening a new line and no filetype-specific indenting is enabled, keep
    " the same indent as the line you're currently on. Useful for READMEs, etc.
    set autoindent

    " Do auto indenting but do it smartly
    set smartindent


    " Instead of failing a command because of unsaved changes, instead raise a
    " dialogue asking if you wish to save changed files.
    set confirm

    " Use visual bell instead of beeping when doing something wrong
    set visualbell

    " And reset the terminal code for the visual bell.  If visualbell is set, and
    " this line is also included, vim will neither flash nor beep.  If visualbell
    " is unset, this does nothing.
    set t_vb=

    " Enable use of the mouse for all modes
    set mouse=a

    " I don't like this but will play with it someitme later
    " Set the command window height to 2 lines, to avoid many cases of having to
    " "press <Enter> to continue"
    " set cmdheight=2

    " Display line numbers on the left
    " I prefer to use the F3 mapping, see F3 mapping below
    " set number

    " Quickly time out on keycodes, but never time out on mappings
    "set notimeout ttimeout ttimeoutlen=200
    " Don't wait 1s when pressing <esc> taken from:
    " http://dominique.pelle.free.fr/.vimrc.html
    set timeout timeoutlen=3000 ttimeoutlen=100

    " Very useful for me
    " Use <F2> to toggle between 'paste' and 'nopaste'
    set pastetoggle=<F2>

    " Stop certain movements from always going to the first character of a line.
    " While this behaviour deviates from that of Vi, it does what most users
    " coming from other editors would expect.
    set nostartofline

    " Show match, briefly jumps to the matching bracket
    set showmatch

    " Undo features
    " taken from: http://dominique.pelle.free.fr/.vimrc.html
    if has('persistent_undo')
        set undodir=~/UNDO
        set undofile
    endif
    if exists('+undoreload')  | set undoreload=100000    | endif

    " Status Line Mod {
        if has('statusline')
            " Always display the status line, even if only one window is displayed
            set laststatus=2

            " Function used to display syntax group.
            function! SyntaxItem()
                let syntaxitem = synIDattr(synID(line("."),col("."),1),"name")
                if syntaxitem != ""
                    let syntaxitem = " [" . syntaxitem . "]"
                endif
                return syntaxitem
            endfunction

            " Function used to display utf-8 sequence.
            function! ShowUtf8Sequence()
                try
                    let p = getpos('.')
                    redir => utfseq
                    sil normal! g8
                    redir End
                    call setpos('.', p)
                    return substitute(matchstr(utfseq, '\x\+ .*\x'), '\<\x', '0x&', 'g')
                catch
                    return '?'
                endtry
            endfunction


            " This status line mod taken from spf-13
            " Broken down into easily includeable segments
            set statusline=%n                             " buffer number
            set statusline+=%{'/'.bufnr('$')}\             " buffer count
            set statusline+=%<%f\ " Filename
            set statusline+=%w%h%m%r " Options
            set statusline+=%{fugitive#statusline()} " Git Hotness

            " This taken from the below status line mod
            " modified by me.
            " File type information
            set statusline+=%#User1#                       " highlighting
            set statusline+=\ [%{&ff}/%Y " start filetype information
            set statusline+=%{(&key==\"\"?\"\":\"/encr\")} " encrypted?
            set statusline+=/%{(&fenc==\"\"?&enc:&fenc)}   " encoding
            set statusline+=%{((exists(\"+bomb\")\ &&\ &bomb)?\"/B\":\"\")} " BOM
            set statusline+=\] " close filetype information

            set statusline+=\ [%{getcwd()}] " current dir
            set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char

            " This taken from the below status line mod
            set statusline+=%{SyntaxItem()}                " syntax group under cursor

            set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info

            " Fancy status line., taken fomr: http://dominique.pelle.free.fr/.vimrc.html
            "set statusline =
            "set statusline+=%#User1#                       " highlighting
            "set statusline+=%n                             " buffer number
            "set statusline+=%{'/'.bufnr('$')}\             " buffer count
            "set statusline+=%#User2#                       " highlighting
            "set statusline+=%f                             " file name
            "set statusline+=%#User1#                       " highlighting
            "set statusline+=%h%m%r%w\                      " flags
            "set statusline+=%{(&key==\"\"?\"\":\"encr,\")} " encrypted?
            "set statusline+=%{strlen(&ft)?&ft:'none'},     " file type
            "set statusline+=%{(&fenc==\"\"?&enc:&fenc)},   " encoding
            "set statusline+=%{((exists(\"+bomb\")\ &&\ &bomb)?\"B,\":\"\")} " BOM
            "set statusline+=%{&fileformat},                " file format
            "set statusline+=%{&spelllang},                 " spell language
            "set statusline+=%(%{Tlist_Get_Tagname_By_Line()}%), " Function name
            "set statusline+=%{SyntaxItem()}                " syntax group under cursor
            "set statusline+=%=                             " indent right
            "set statusline+=%#User2#                       " highlighting
            "set statusline+=%{ShowUtf8Sequence()}\         " utf-8 sequence
            "set statusline+=%#User1#                       " highlighting
            "set statusline+=U+%04B\                        " Unicode char under cursor
            "set statusline+=%-6.(%l/%{line('$')},%c%V%)\ %<%P           " position
        endif

    " }
    " Folding {
        set foldmethod=syntax
        set foldlevelstart=1
        " auto open and close folds, comment the following line if you don't
        " liek that "
        set foldopen=all,insert
        set foldclose=all

        let javaScript_fold=1         " JavaScript
        let perl_fold=1               " Perl
        let php_folding=1             " PHP
        let r_syntax_folding=1        " R
        let ruby_fold=1               " Ruby
        let sh_fold_enabled=1         " sh
        let vimsyn_folding='af'       " Vim script
        let xml_syntax_folding=1      " XML
    " }
    " VimDiff {
        " Ignore white space and look for actual changes only
        set diffopt+=iwhite
    " }
" }

" Vim User Interface {

    " GUI {
        " Gui interface
        if has('gui_running')
          if has("win16") || has("win32") || has("win95") || has("win64")
            set guifont=Lucida\ Console:h10
          else
            set guifont=Monospace\ 9
          endif
          if exists('+toolbar') | set tb=icons  | endif
          if exists('tbis')     | set tbis=tiny | endif
        else
          if has('eval') | let Tlist_Inc_Winwidth=0 | endif
        endif
    " }

    " Ruler {
        " Display cursor position on the last line
        set ruler

        " The ruler format from spf-13
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    " }

    " Others {
        set cursorline  " highlight current line
    " }

" }

" Tags {
    " Taken from spf-13
    " Search tags file in current directory and the upward to root till one is
    " found
    set tags=./tags;/,$HOME/vimtags

    " Tag Setup
    " Still needs to be done
    " TODO: Write a vim plugin that will run the ctags on current file and update the tags file in current
    "       directory
    " TODO: A key mapping to manually update the tags file in current directory
    " TODO: A shell script to run ctags and create project wide tags file
    " TODO: The shell could also delete sub tags file
    " A master tag file will be in project's root directory.
    " So the new tags will be instantly available in our local per-directory
    " tags file.
" }

" Indentation {
    " Global Indentation Settings {
        " Indentation settings for using 4 spaces instead of tabs.
        " Do not change 'tabstop' from its default value of 8 with this setup.
        set shiftwidth=4
        set softtabstop=4
        set expandtab

        " When using < and > shift to round
        " it defaults to shifting to multiple of shiftwidth
        set shiftround

        " Indentation settings for using hard tabs for indent. Display tabs as
        " two characters wide.
        "set shiftwidth=2
        "set tabstop=2
    " }

    " PHP Indentation {
        " Wordpress Coding Standard baby. ;)
        autocmd FileType php setlocal tabstop=4
        autocmd FileType php setlocal noexpandtab
        autocmd FileType php setlocal autoindent
        autocmd FileType php setlocal smartindent
    " }

    " Python Indentation {
        " PEP8 Coding Standard baby - http://www.python.org/dev/peps/pep-0008/
        autocmd FileType python setlocal tabstop=8 
        autocmd FileType python setlocal expandtab
        autocmd FileType python setlocal shiftwidth=4
        autocmd FileType python setlocal softtabstop=4
        autocmd FileType python setlocal textwidth=79

    " }

" }

" Syntax Highlighting {
    " PHP Syntax { "
        " http://www.vim.org/scripts/script.php?script_id=2874
        let php_sql_query = 1  "for SQL syntax highlighting inside strings
        let php_html_in_strings = 1  "for HTML syntax highlighting inside strings
        "php_parent_error_close = 1  "for highlighting parent error ] or )
        "php_parent_error_open = 1  "for skipping an php end tag, if there exists an open ( or [ without a closing one
        let php_no_shorttags = 1  "don't sync <? ?> as php
        let php_folding = 1  "for folding classes and functions

    " }
" }

" Mappings {

    " Taken from spf-13
    "The default leader is '\', but many people prefer ',' as it's in a standard "location
    let mapleader = ','

    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :

    " Copy to clipboard
    vmap <C-C> "+ygv"zy`>
    
    " Easier moving in tabs and windows
    " only j and k are enough for me
    map <C-S-J> <C-W>j<C-W>_
    map <C-S-K> <C-W>k<C-W>_

    " Tabs {
        " tab navigation like firefox
        " taken from http://vim.wikia.com/wiki/Alternative_tab_navigation "
        map <C-left> :tabp<CR>
        map <C-right> :tabn<CR>
        imap <C-left>   <Esc>:tabp<CR>
        imap <C-right>  <Esc>:tabn<CR>
    " }

    " This mapping allows to stay in visual mode when indenting with < and >
    vnoremap > >gv
    vnoremap < <gv
    " Indenting via tab"
    "inoremap <S-Tab> <C-O><lt><lt>
    "nnoremap <Tab> >>
    "nnoremap <S-Tab> <lt><lt>
    "vnoremap <Tab> >
    "vnoremap <S-Tab> <lt>

    " Disabled because c-] is for tag definition
    " and c-g is for showing information in the command line, yes I use it.
    "noremap <c-]> g<c-]>
    "noremap <c-g> g<c-g>

    " These mappings are useful in long wrapped lines when pressing <down> or <up>
    " Use j or k to get the default behavior.
    noremap <down> gj
    noremap <up>   gk

    " <F2 has been mapped to pastetoggle see :set pastetoggle"
    map <F3>      :set number!<CR>:set number?<CR>
    imap <F3> <C-O>:set number!<CR><C-O>:set number?<CR>
    map <F4>      :set hlsearch!<CR>:set hlsearch?<CR>
    imap <F4> <C-O>:set hlsearch!<CR><C-O>:set hlsearch?<CR>
    map <C-F5>      :set list!<CR>:set list?<CR>
    imap <C-F5> <C-O>:set list!<CR><C-O>:set list?<CR>
    nnoremap <silent> <C-F6> :TlistToggle<CR>

    " Useful when I am done with search
    " Map <C-L> (redraw screen) to also turn off search highlighting until the
    " next search
    nnoremap <C-L> :nohl<CR><C-L>

    " Serch word under cursor in current dir
    map <C-F> <esc>:Grep<CR>
    map <C-R> <esc>:Rgrep<CR>

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null
" }

" Auto Complete {
        " Supertab Auto complete {
            " Taken from spf-13
            " make sure that omni completion doesn't break supertab
            let g:SuperTabCrMapping = 0
        " }

        set ofu=syntaxcomplete#Complete
" }

" FileType Commands and Settings {
    " This section's purpose is to setup file type level settings
    " mainly for development purpose

    " Removes trailing whitespaces from code  
    " This causes vim to hang for 5-6 seconds when writing some files
    " shold map it to some key, that will be more useful
    " autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
    " Source .vimrc when I write it.  The nested keyword allows
    " autocommand ColorScheme to fire when sourcing ~/.vimrc.
    autocmd! BufWritePost .vimrc nested source %

    " Automatic commands. {

        " If swapfile exists assume 'e' as the response i.e edit anyway
        autocmd SwapExists * let v:swapchoice = 'e'

        autocmd BufReadPost */etc/* setlocal textwidth=0
        autocmd BufReadPost */var/log/* setlocal ft=messages
        autocmd BufReadPost ~/.vim-plugin-tool.conf setl ft=dosini nospell

        " Automatically sort word lists and generate spell files.
        autocmd BufWritePre */spell/*.add %sort i
        autocmd BufWritePost */spell/*.add silent mkspell! %


        " Note, perl automatically sets foldmethod in the syntax file
        autocmd Syntax c,cpp,vim,xml,html,xhtml,php setlocal foldmethod=syntax
        autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR
    " }

    "TODO: disabled this autocmd because not working on windows"
    " auto change directory from: http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
    "autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | lcd %:p:h | endif
    set autochdir

    " Auto Commands For Python {
        " Enable omni-completion in Python scripts.
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

        " Hide # comment markers from folded text in Python scripts.
        autocmd FileType python setlocal commentstring=#%s

        " Set fold method in python scripts to be indent based
        autocmd FileType python setlocal foldmethod=indent

        " Set Ctrl + M to run Python script
        autocmd FileType python noremap <C-M> :w!<CR>:!/usr/bin/env python %<CR>

    " }

    " Auto Commands for PHP Files {
        " PHP Autocomplete
        autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

        autocmd FileType php setlocal textwidth=0

        " Enable completion dictionaries for PHP and Python buffers.
        autocmd FileType php setlocal complete+=k~/.vim/dict/PHP.dict

        " run file with PHP CLI (CTRL-M)
        autocmd FileType php noremap <C-M> :w!<CR>:!/usr/bin/php %<CR>
    " }

    autocmd FileType messages setlocal nowrap nomodifiable nospell
    autocmd FileType c setlocal cms=/*%s*/
    autocmd FileType gitcommit setlocal autoindent
    autocmd FileType sh setlocal isfname-==
    autocmd FileType sh setlocal textwidth=0

" }

" Plugins Specific Settings {
    " CtrlP {
        " Temporarily Ctrl+M assigned to ctrlp
        " Ctrl+P are used for adding PHPdoc comments
        let g:ctrlp_map = '<c-m>'

        " there is no point to make it search the whole project
        " slow and takes long time
        let g:ctrlp_working_path_mode = 'ra'

        "nmap <leader>be :CtrlPBuffer<CR>
        nmap <leader>cp :CtrlPBuffer<CR>
        nmap <leader>bm :CtrlPMixed<CR>
        cmap CP CtrlP

        " TODO: comapre command-t and ctrlp
        " below line will be removed/uncommented
        " once I do the comparison of command-to and ctrlp
        "nmap <leader>t :CtrlP<CR>
    " }
    
    " Delimitmate {
        au FileType * let b:delimitMate_autoclose = 1

        " If using html auto complete (complete closing tag)
        au FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"
    " }

    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    " }


    " SnipMate {
        " Taken from spf-13
        " Setting the author var
        " If forking, please overwrite in your .vimrc.local file
        let g:snips_author = 'Hameedullah Khan <h@hameedullah.com>'

        " The custom snipmate directory
        let g:snippets_dir="$HOME/.vim/bundle/snipmate-snippets/snippets"
        " Shortcut for reloading snippets, useful when developing
        nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>
    " }

    " Super Tab {"
        " When using context completion, super tab will fall back to a secondary default
        " completion type set by |g:SuperTabContextDefaultCompletionType|.
        let g:SuperTabDefaultCompletionType = "context"
        let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

    " }

    " NERDTree {
        " Key Mappings for NERD Tree Plugin
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nf :NERDTreeFind<CR>

        " Other NERD Tree configurations
        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        "let NERDTreeDirArrowExpandable = '+'
        "let NERDTreeDirArrowCollapsible = '-'
        "let NERDTreeDirArrows=0
        " NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('sh*', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('sh', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


    " }


    " Buffer explorer {
        " Disable BufExplorer
        " To enable BufExploere comment out the very next line.
        "let g:bufexplorer_version = "7.2.8"

        " TODO: Get used to a mapping
        "  Currently the leader based mapping seems very slow
        if !exists("g:bufexplorer_version")
            nmap <leader>be :BufExplorer<CR>
            cmap BE BufExplorer
        endif

    " }

    " VCSCommand Configuration {
        " delete vcs buffer on hide
        let VCSCommandDeleteOnHide = 1

        " Custom Mappings
        nmap <leader>vb :VCSBlame<CR>
        nmap <leader>va <Plug>VCSAdd
        nmap <leader>vn <Plug>VCSAnnotate
        nmap <leader>vN <Plug>VCSAnnotate!
        nmap <leader>vc <Plug>VCSCommit
        nmap <leader>vD <Plug>VCSDelete
        nmap <leader>vd <Plug>VCSDiff
        nmap <leader>vg <Plug>VCSGotoOriginal
        nmap <leader>vG <Plug>VCSGotoOriginal!
        nmap <leader>vi <Plug>VCSInfo
        nmap <leader>vl <Plug>VCSLog
        nmap <leader>vL <Plug>VCSLock
        nmap <leader>vr <Plug>VCSReview
        nmap <leader>vs <Plug>VCSStatus
        nmap <leader>vu <Plug>VCSUpdate
        nmap <leader>vU <Plug>VCSUnlock
        nmap <leader>vv <Plug>VCSVimDiff
    " }

    " Ctrl {
        let g:ctrlp_map = '<c-p>'
    " }

    " VimDebugger {
        " Eclipse debugger commands
        "   F5      Step into
        "   F6      Step over
        "   F7      Run to return
        "   F8      Resume
        "   F9       Relaunch last
        "   F11     Run/debug last
        "   Ctrl F11        Run
        "   Ctrl Shift B    Toggle breakpoint
        "   Ctrl D  Display
        "   Ctrl Q  Inspect
        "    Ctrl R  Run to line
        "    Ctrl U  Run snippet
        map <F5> :DbgStepInto<CR>
        map <S-F5> :DbgStepOut<CR>
        map <F6> :DbgStepOver<CR>
        map <C-F11> :DbgRun<CR> 
        " TODO: Play with debug detach and map it if useful
        "map <F6> :DbgDetach<CR>
        "map <F8> :DbgToggleBreakpoint<CR>
        map <C-S-B> :DbgToggleBreakpoint<CR>
        map <S-F8> :DbgFlushBreakpoints<CR>
        map <F9> :DbgRefreshWatch<CR>
        map <S-F9> :DbgAddWatch<CR>
    " }
    
    " Lusty Eplorer and Juggler {
        " disable lusty juggler for timebeing, as it is breaking delimitMate
        let g:loaded_lustyjuggler = "yep"
        let g:LustyExplorerSuppressRubyWarning = 1

        " Lusty Explorer default key mappings
        ":LustyFilesystemExplorer 
        ":LustyFilesystemExplorerFromHere 
        ":LustyBufferExplorer 
        ":LustyBufferGrep (for searching through all open buffers) 

        "<Leader>lf  - Opens filesystem explorer. 
        "<Leader>lr  - Opens filesystem explorer at the directory of the current file.   
        "<Leader>lb  - Opens buffer explorer. 
        "<Leader>lg  - Opens buffer grep. 

        " Lusty juggler default key mappings
        " very useful for quickly switching between recently opened buffers
        " buffer explorer is always there to see all opened buffers with useful information
        " but this one allows you to quickly swtich between them and lists them
        " in recently opened order
        "Launch the juggler with this key combo: 

        "<Leader>lj 

        "The command bar at bottom is replaced with a new bar showing the names of your currently opened buffers in most-recently-used order. 

        "The buffer names are mapped to these keys: 

        "1st --> a or 1 
        "2nd --> s or 2 
        "3rd --> d or 3 
        "4th --> f or 4 
        "5th --> g or 5 
        "6th --> h or 6 
        "7th --> j or 7 
        "8th --> k or 8 
        "9th --> l or 9 
        "10th --> ; or 0 

        "So if you type "f" or "4", the fourth buffer name will be highlighted and the bar will shift to center it as necessary (and show more of the buffer names on the right). 

        "If you want to switch to that buffer, press "f" or "4" again or press "<ENTER>".  Alternatively, press one of the other mapped keys to highlight another buffer. 
    " }
    
    " PDV phpDocumentor for Vim Plugin {
        " PHP doc key mappings
        "inoremap <C-d> <ESC>:call PhpDocSingle()<CR>i 
        "nnoremap <C-d> :call PhpDocSingle()<CR> 
        "vnoremap <C-d> :call PhpDocRange()<CR>

        nmap <Leader>pd :call PhpDocSingle()<CR>
        vmap <Leader>pd :call PhpDocRange()<CR>

        " Default Variable Values
        " The author details
        let g:pdv_cfg_Author = "Hameedullah Khan <h@hameedullah.com>"
        " The copy right statement
        let g:pdv_cfg_Copyright = "Copyright 2011 Hameedullah Khan"
        " The licence
        let g:pdv_cfg_License = "GNU General Public License http://www.gnu.org/licenses/gpl.txt"

        """"""""""""""""""""""""""""""""""""""""""""""""""""
        " Normally the below are not needed to be modified
        " TODO: add description of the variables, to explain their function
        let g:pdv_cfg_Type = "mixed"
        let g:pdv_cfg_Package = ""
        let g:pdv_cfg_Version = "$id$"
        let g:pdv_cfg_ReturnVal = "void"

    " }
    
    " Tasklist {
        " A todo reminder plugin that lists all your TODO, FIXME in current file:
        " http://www.vim.org/scripts/script.php?script_id=2607

        "<Leader>v
        map <leader>tl <Plug>TaskList

        " custom token list
        " add @todo, to parse the todo from PHPDoc Comments
        let g:tlTokenList = ["FIXME", "TODO", "XXX", "@todo"]

        let g:tlWindowPosition=1

    " }
    
    " Taglist {
        " Taken from spf-13
        let Tlist_Auto_Highlight_Tag = 1
        let Tlist_Auto_Update = 1
        let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
        let Tlist_File_Fold_Auto_Close = 1
        let Tlist_Highlight_Tag_On_BufEnter = 1
        let Tlist_Use_Right_Window = 1
        let Tlist_Use_SingleClick = 1
        let Tlist_Show_One_File = 1       " Only show tags for current buffer
        let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)

        let g:ctags_statusline=1
        " Override how taglist does javascript
        let g:tlist_javascript_settings = 'javascript;f:function;c:class;m:method;p:property;v:global'

        let g:tlist_sql_settings = 'sql;P:package;t:table'
    " }
" }

" Functions {
    function! InitializeDirectories()
        let separator = "."
        let parent = $HOME
        let prefix = '.vim'
        " Added slash at the end of swap directory name 'read :h directory' okay
        let dir_list = { 'backup': 'backupdir', 'views': 'viewdir', 'swap/': 'directory' }

        for [dirname, settingname] in items(dir_list)
            " Create backup, views and swap folders inside .vim
            " I don't like cluttering my homedirectory
            let directory = parent . '/' . prefix . '/' . dirname . "/"
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "")
                let thesetting = 'set ' . settingname . '=' . directory
                exec thesetting
            endif
        endfor
    endfunction
    call InitializeDirectories() 
" }

" Other Not Aligned Options {

    " Change color of cursor in terminal:
    " - red in normal mode.
    " - orange in insert mode.
    " Tip found there:
    "   http://forums.macosxhints.com/archive/index.php/t-49708.html
    " It works at least with: xterm rxvt eterm
    " But do nothing with: gnome-terminal terminator konsole xfce4-terminal
    "if version >= 700
    "    if &term =~ "xterm\\|rxvt"
    "    ":silent !echo -ne "\033]12;red\007"
    "    let &t_SI = "\033]12;orange\007"
    "    let &t_EI = "\033]12;red\007"
    "    au! VimLeave * :sil !echo -ne "\033]12;red\007"
    "    endif
    "endif

    " vim -b : edit binary using xxd-format
    " See :help hex-editing
    "augroup Binary
    "    au!
    "    au BufReadPre   *.dat let &bin=1
    "    au BufReadPost  *.dat if  &bin   | %!xxd
    "    au BufReadPost  *.dat set ft=xxd | endif
    "    au BufWritePre  *.dat if  &bin   | %!xxd -r
    "    au BufWritePre  *.dat endif
    "    au BufWritePost *.dat if  &bin   | %!xxd
    "    au BufWritePost *.dat set nomod  | endif
    "augroup END

    " omnicomplete from: http://vim.wikia.com/wiki/VimTip1386
    "set completeopt=longest,menuone
    "inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    "inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
    "\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

    " this key mapping never worked for me
    "inoremap <expr> <M-,> pumvisible() ? '<C-n>' : "  
    "    \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


    " Session.vim settings
    ":let g:session_autosave = 1
    ":let g:session_autoload = 1

    " Taken from http://peterodding.com/code/vim/profile/vimrc
    " Do use the currently active spell checking for completion though!
    " (I love this feature :-)
    set complete+=kspell


    " to reduce the number of buffers while using sessions
    set ssop-=buffers



" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }
"
"
" Unsorted Changes
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader>nn :split note:new note<cr>
nmap <Leader>ns :SearchNotes 
