"
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" MISCELLANEOUS {{{
"
" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file is use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to the file.
set relativenumber
set number

" Highlight cursor line and column underneath the cursor
set cursorline " faster to not render
set nocursorcolumn " slower than line but doesn't break ligatures

" Set an 80 column border for good coding style
set cc=80

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" indent a new line the same amount as the line just typed
set autoindent

" Do not save backup files.
" set nobackup

" set tab to visible character
" set listchars=tab:▷▷⋮
" set list lcs=tab:\▏\
" this takes up way too much cpu for some reason so I disabled it

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=4

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Enable mouse click
set mouse=a

" Middlie-click paste
set mouse+=v

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" get zsh-like tab completions
set wildmode=longest,full

" Speed up scrolling in Vim
set nottyfast

" Search upwards for tags file instead only locally
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

let mapleader=" "
let maplocalleader=" "

if executable("xsel")

  function! PreserveClipboard()
    call system("xsel -ib", getreg('+'))
  endfunction

  function! PreserveClipboadAndSuspend()
    call PreserveClipboard()
    suspend
  endfunction

  autocmd VimLeave * call PreserveClipboard()
  nnoremap <silent> <c-z> :call PreserveClipboadAndSuspend()<cr>
  vnoremap <silent> <c-z> :<c-u>call PreserveClipboadAndSuspend()<cr>

endif

" }}}

" PLUGINS {{{

set background=dark
colorscheme slate

if empty($INFECT) || $INFECT == '0'
    execute pathogen#infect()
elseif $INFECT == '1'
    execute pathogen#infect('bundle/{}', 'extra/{}')
else
    execute pathogen#infect('bundle/{}', $INFECT . '/{}' )
endif

if $UID != "0"
    colorscheme dracula

    let g:lightline = {
          \ 'colorscheme': 'dracula',
          \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
          \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
          \ }

    let g:indentLine_char = '│'
endif

" }}}

" KEYBINDINGS {{{
" Remap K to Esc because the man page feature is actually pretty annoying
nnoremap K <ESC>

" kitty opacity compatibility
" let &t_ut=""

nnoremap <leader>´ ``

nnoremap <leader>bn :bn<CR>
nnoremap <leader>nb :bp<CR>
nnoremap <leader>bN :bp<CR>

nnoremap <leader>et :term<CR>

" NERDTree Mappings
nnoremap <leader>ntt :NERDTreeToggle<CR>
nnoremap <leader>ntf :NERDTreeFocus<CR>
nnoremap <leader>ntc :NERDTreeClose<CR>
nnoremap <leader>nte :NERDTreeExplore<CR>

" Fugitive mappings
nnoremap <leader>fgp :Git push
nnoremap <leader>fga :Git add %<CR>
nnoremap <leader>fgc :Git add %<CR>:Git commit -m "

" Type jj to exit insert mode quickly.
inoremap jk <Esc>
inoremap jK <Esc>

" Press the space bar to type the : character in command mode.
nnoremap <leader><space> :

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
" nnoremap o o<esc>
" nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Yank from cursor to the end of line.
nnoremap Y y$

" Render the ctags inside Vim.
nnoremap <F5> :w <CR>:!ctags -R .<CR>

" You can split the window in Vim by typing :split or :vsplit.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Move Lines
" nnoremap <a-j> :execute 'move .+' . v:count1<CR>==
" nnoremap <a-k> <cmd>execute 'move .-' . (v:count1 + 1)<cr>==
" inoremap <a-j> <esc><cmd>m .+1<cr>==gi
" inoremap <a-k> <esc><cmd>m .-2<cr>==gi
vnoremap <s-j> :<C-u>execute "'<,'>move '>+" . v:count1<cr>gv=gv
vnoremap <s-k> :<C-u>execute "'<,'>move '<-" . (v:count1 + 1)<cr>gv=gv

" from: https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
" If you want n to always search forward and N backward, use this:
nnoremap <expr> n  'Nn'[v:searchforward].'zz'
xnoremap <expr> n  'Nn'[v:searchforward].'zz'
onoremap <expr> n  'Nn'[v:searchforward].'zz'
nnoremap <expr> N  'nN'[v:searchforward].'zz'
xnoremap <expr> N  'nN'[v:searchforward].'zz'
onoremap <expr> N  'nN'[v:searchforward].'zz'

" going to next and previous items via <c-n> and <c-p> respectively
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

" edit macros at the command line
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" keep in visual mode
xnoremap <  <gv
xnoremap >  >gv

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
nnoremap <c-up> <c-w>+
nnoremap <c-down> <c-w>-
nnoremap <c-left> <c-w>>
nnoremap <c-right> <c-w><

" replace the word under the cursor with whatever you want
nnoremap <Leader>cw *``cgn
nnoremap <Leader>cW #``cgN

" copy/paste the right way
nnoremap <leader>p "+p
nnoremap <Leader>P "+P
nnoremap <Leader>y "+y
nnoremap <Leader>Y "+y$
xnoremap <Leader>y "+y
xnoremap <Leader>p "+p

" Enter Normal Mode
tnoremap <esc><esc> <c-\><c-n>

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
" nnoremap <F3> :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" }}}

" VIMSCRIPT {{{

" auto reload file on saving
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" change cursor style depending on mode
if empty($TMUX)
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif

" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" If the current file type is HTML,pug,handlebars, set indentation to 2 spaces.
augroup filetype_htm
    autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd Filetype pug setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd Filetype hbs setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    " Enable undofile and set undodir and backupdir
    let s:dir = has('win32') ? '$APPDATA/Vim' : isdirectory($HOME.'/Library') ? '~/Library/Vim' : empty($XDG_STATE_HOME) ? '~/.local/state/vim' : '$XDG_DATA_HOME/vim'
    let &backupdir = expand(s:dir) . '/backup//'
    let &undodir   = expand(s:dir) . '/undo//'
    let &directory = expand(s:dir) . '/swp//'
    set undofile
    set undoreload=512
endif

" Automatically create directories for backup and undo files.
if !isdirectory(expand(s:dir))
    call system("mkdir -p " . expand(s:dir) . "/{backup,undo,swp}")
end

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline nocursorcolumn
augroup END

" let g:airline_theme='base16_dracula'
" let g:indentLine_setColors = 0

if (has('termguicolors') || &termguicolors) && has('gui_running') || &t_Co == 256
    set termguicolors
endif
" If GUI version of Vim is running set these options.
if has('gui_running')
    set background=dark
    colorscheme dracula

    " Set a custom font you have installed on your computer.
    " Syntax: <font_name>\ <weight>\ <size>
    set guifont=FiraCode\ Nerd\ Font\ Mono\ weight=450\ 13

    " Display more of the file by default.
    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the left-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

    " Map the F4 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
    nnoremap <F9> :if &guioptions=~#'mTr'<Bar>
                \set guioptions-=mTr<Bar>
                \else<Bar>
                \set guioptions+=mTr<Bar>
                \endif<CR><Esc>

    " Change airline trail
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''

    let g:airline_theme='dracula'

endif

" }}}

" STATUS LINE & UI {{{

set fillchars+=vert:\\u2502
highlight CursorColumn guibg=#21222c
highlight CursorLine guibg=#21222c

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=▲\ %F\ >\ %M\ %Y\ %R\ >

" Use a divider to separate the left side from the right side.
set statusline+=%=
" 
" Status line right side.
set statusline+=\ <\ %l,%c\ <\ @%p%%\ ▲

" Show the status on the second to last line.
set laststatus=2

" }}}

