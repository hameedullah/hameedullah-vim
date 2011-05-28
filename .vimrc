" Modeline, Author and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~/.vimrc                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Hameedullah Khan                                      "
" Email: h@hameedullah.com                                      "
"                                                               "
" Version: 0.2                                                  "
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
        set nocompatible 
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

    " Pathogen {
        " This is actually the cool idea to keep plugins in their own separate folder to have a cleaner .vim-directory
        " Giving it a try
        " Copying spf-13
        " The next two lines ensure that the ~/.vim/bundle/ system works
        runtime! autoload/pathogen.vim
        silent! call pathogen#helptags()
        silent! call pathogen#runtime_append_all_bundles()
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
    " Use <F10> to toggle between 'paste' and 'nopaste'
    set pastetoggle=<F10>

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
                return synIDattr(synID(line("."),col("."),1),"name")
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


            " This status line mod takne from spf-13
            " Broken down into easily includeable segments
            set statusline=%<%f\ " Filename
            set statusline+=%w%h%m%r " Options
            "set statusline+=%{fugitive#statusline()} " Git Hotness
            set statusline+=\ [%{&ff}/%Y] " filetype
            set statusline+=\ [%{getcwd()}] " current dir
            "set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
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
	set cursorline  				" highlight current line
	hi cursorline guibg=#333333 	" highlight bg color of current line
	hi CursorColumn guibg=#333333   " highlight cursor

    " }

" }

" Indentation {
    " Global Indentation Settings {
        " Indentation settings for using 2 spaces instead of tabs.
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

" }

" Mappings {

    " Taken from spf-13
    "The default leader is '\', but many people prefer ',' as it's in a standard "location
    let mapleader = ','

    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :

    " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Tabs {
        " tab navigation like firefox
        " taken from http://vim.wikia.com/wiki/Alternative_tab_navigation "
        nmap <C-S-tab> :tabprevious<CR>
        nmap <C-tab> :tabnext<CR>
        map <C-S-tab> :tabprevious<CR>
        map <C-tab> :tabnext<CR>
        imap <C-S-tab> <Esc>:tabprevious<CR>i
        imap <C-tab> <Esc>:tabnext<CR>i
        nmap <C-t> :tabnew<CR>
        imap <C-t> <Esc>:tabnew<CR>"
    " }

    " This mapping allows to stay in visual mode when indenting with < and >
    vnoremap > >gv
    vnoremap < <gv

    noremap <c-]> g<c-]>
    noremap <c-g> g<c-g>

    " These mappings are useful in long wrapped lines when pressing <down> or <up>
    " Use j or k to get the default behavior.
    noremap <down> gj
    noremap <up>   gk

    map <F2>      :set paste!<CR>:set paste?<CR>
    imap <F2> <C-O>:set paste<CR>:set paste?<CR>
    map <F3>      :set number!<CR>:set number?<CR>
    imap <F3> <C-O>:set number!<CR><C-O>:set number?<CR>
    map <F4>      :set hlsearch!<CR>:set hlsearch?<CR>
    imap <F4> <C-O>:set hlsearch!<CR><C-O>:set hlsearch?<CR>
    map <F5>      :set list!<CR>:set list?<CR>
    imap <F5> <C-O>:set list!<CR><C-O>:set list?<CR>
    nnoremap <silent> <F6> :TlistToggle<CR>

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

" FileType Commands and Settings {
    " This section's purpose is to setup file type level settings
    " mainly for development purpose

    " Removes trailing whitespaces from code  
    " This causes vim to hang for 5-6 seconds when writing some files
    " shold map it to some key, that will be more useful
    " autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))


" }

" Plugins Specific Settings {

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
        " Setting the author var
        " If forking, please overwrite in your .vimrc.local file
        let g:snips_author = 'Hameedullah Khan <h@hameedullah.com>'
        " Shortcut for reloading snippets, useful when developing
        nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>
    " }


    " NerdTree {
        " Key Mappings for NERD Tree Plugin
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        nmap <leader>nf :NERDTreeFind<CR>

        " Other NERD Tree configurations
        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
    " }

    " Buffer explorer {
        " TODO: Get used to a mapping
        "  Currently the leader based mapping seems very slow
        nmap <leader>be :BufExplorer<CR>
        cmap BE BufExplorer
    " }

    " VCS commands {
        nmap <leader>vs :VCSStatus<CR>
        nmap <leader>vc :VCSCommit<CR>
        nmap <leader>vb :VCSBlame<CR>
        nmap <leader>va :VCSAdd<CR>
        nmap <leader>vd :VCSVimDiff<CR>
        nmap <leader>vl :VCSLog<CR>
        nmap <leader>vu :VCSUpdate<CR>
    " }
" }

" Functions {
    function! InitializeDirectories()
        let separator = "."
        let parent = $HOME
        let prefix = '.vim'
        let dir_list = {
                        \ 'backup': 'backupdir',
                        \ 'views': 'viewdir',
                        \ 'swap': 'directory' }

        for [dirname, settingname] in items(dir_list)
            let directory = parent . '/' . prefix . dirname . "/"
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
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories() 
" }

" Other Not Aligned Options {
    if has('autocmd')
    " Source .vimrc when I write it.  The nested keyword allows
    " autocommand ColorScheme to fire when sourcing ~/.vimrc.
    au! BufWritePost .vimrc nested source %

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

    endif

    """ Test these options and then enable only that suite my style.
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


    " Taken from http://peterodding.com/code/vim/profile/vimrc
    " Make Vim open and close folded text as needed because I can't be bothered to
    " do so myself and wouldn't use text folding at all if it wasn't automatic.
    " set foldmethod=marker foldopen=all,insert foldclose=all
    " Folding
    set foldmethod=indent foldopen=all,insert foldclose=all
    set foldlevel=1

    " to reduce the number of buffers while using sessions
    set ssop-=buffers



    " Automatic commands. {

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
    " }

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
    "nmap <silent> <F3> <Plug>ToggleProject
    "let g:proj_window_width = 30
    "let g:proj_window_increment = 150

    " auto change directory from: http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
    autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | lcd %:p:h | endif

" }

