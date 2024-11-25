" vim: et ts=2 sts=2 sw=2
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
set relativenumber number

" Highlight cursor line and column underneath the cursor
set cursorline nocursorcolumn

" Set an 80 column border for good coding style
set colorcolumn=80

" Set shift width to 4 spaces, set tab width to 4 columns.
" Use space characters instead of tabs.
set sw=4 ts=4 et sts=4

" indent a new line the same amount as the line just typed
set autoindent

" Do save backup files.
set backup

" Do not let cursor scroll below or above N number of lines when scrolling.
" Do not wrap lines. Allow long lines to extend as far as the line goes.
set scrolloff=4 nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase ignorecase

" Show partial command you type in the last line of the screen.
" Show the mode you are on the last line.
set showcmd showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Enable mouse click
set mouse=a

" Set the commands to save in history default number is 20.
set history=10000

" Enable auto completion menu after pressing TAB.
set wildmenu

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*.webm,*.webp

" get zsh-like tab completions
set wildmode=longest:full,full

" Speed up scrolling in Vim
set ttyfast lazyredraw
" Hide other windows completely
set wmh=0 wmw=0

" Search upwards for tags file instead only locally
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

let mapleader=" "
let maplocalleader=" "

" }}}

" PLUGINS {{{

if empty($INFECT) || $INFECT == '0'
  execute pathogen#infect()
  let g:rc_difffn = 'diff'
  let g:loaded_matchparen = 1
elseif $INFECT == '1'
  execute pathogen#infect('bundle/{}', 'extra/{}')
  let g:rc_difffn = has('gui_running')? 'diff' : 'diffcolor'
  set updatetime=230
else
  execute pathogen#infect('bundle/{}', $INFECT . '/{}' )
  let g:rc_difffn = 'diff'
endif

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  try
    colorscheme slate
  catch | endtry
  let g:webdevicons_enable = 0
  let g:rc_colors = '16color'
  let g:rc_separators = { 'left': "", 'right': "" }
  let g:rc_subseparators = { 'left': "|", 'right': "|" }
  let g:rc_clock_glyph = ''
  let g:rc_branch_glyph = '▲ '
  let g:rc_readonly_glyph = 'RO'
  let g:lightline#gitdiff#indicator_added = '+'
  let g:lightline#gitdiff#indicator_deleted = '-'
  let g:lightline#gitdiff#indicator_modified = '~'
  let g:lightline#gitdiff#separator = ''
  highlight GitGutterChange ctermbg=NONE ctermfg=6
  let g:webdevicons_enable = 0
  let g:webdevicons_enable_nerdtree = 0
else
  set noshowmode
  try
    colorscheme dracula
  catch | endtry
  let g:rc_colors = 'dracula'
  let g:rc_separators = { 'left': "\ue0b0", 'right': "\ue0b2" }
  let g:rc_subseparators = { 'left': "\ue0b1", 'right': "\ue0b3" }
  let g:rc_clock_glyph = ' '
  let g:rc_branch_glyph = ' '
  let g:rc_readonly_glyph = '󰌾 '
  let g:lightline#gitdiff#indicator_added = ' '
  let g:lightline#gitdiff#indicator_deleted = ' '
  let g:lightline#gitdiff#indicator_modified = ' '
  let g:lightline#gitdiff#separator = ' '
  let g:gitgutter_sign_added = '▎'
  let g:gitgutter_sign_modified = '▎'
  let g:gitgutter_sign_removed = '▾'
  let g:gitgutter_sign_removed_first_line = '▲'
  let g:gitgutter_sign_removed_above_and_below = '{'
  let g:gitgutter_sign_modified_removed = ''
  let g:webdevicons_enable_startify = 1
  "highlight GitGutterChange guifg=#8be9fd
  function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) . " " . entry_path'
  endfunction
endif

let g:indentLine_char = '│'
let g:lightline = {
      \ 'colorscheme': g:rc_colors,
      \ 'separator': g:rc_separators,
      \ 'subseparator': g:rc_subseparators,
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],  [ 'fugitive' ], [ 'filename' ]  ],
      \   'right': [ [ 'filemodified', 'searchindex' ],  [ 'cursorinfo' ], [ g:rc_difffn, 'filetype' ]  ]
      \ },
      \ 'inactive': {
      \   'left': [[ 'filename' ]], 'right': [ [ 'lineinfo' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'Vim9LightlineFugitive',
      \   'filename': 'Vim9LightlineFilename',
      \   'filemodified': 'Vim9FileTime',
      \   'searchindex': 'SearchcountStatus',
      \   'diff': 'lightline#gitdiff#get',
      \   'icon_filename': 'Vim9Icon_Filename',
      \ },
      \ 'component': {
      \   'time' : "%9{strftime(\"%m/%d,%H:%M:%S\",getftime(expand(\"%%\")))}",
      \   'cursorinfo': '%2p%% %3l:%-2c',
      \   'diffcolor': "%#User1#%{Vim9GitAdded()}%#User3#%{Vim9GitModified()}%#User2#%{Vim9GitRemoved()}%9*",
      \ },
      \ 'component_visible_condition': {
      \   'diffcolor': "exists('*FugitiveHead') && !empty(FugitiveHead())",
      \   'diff': "exists('*FugitiveHead') && !empty(FugitiveHead())"
      \ }
      \ }

highlight User1 ctermfg=2 ctermbg=0 guifg='#50FA7B' guibg='#44475A'
highlight User2 ctermfg=1 ctermbg=0 guifg='#FF5555' guibg='#44475A'
highlight User3 ctermfg=6 ctermbg=0 guifg='#8BE9FD' guibg='#44475A'
highlight User9 ctermfg=NONE ctermbg=NONE guifg=NONE guibg='#44475A'

if (has('termguicolors') || &termguicolors) && has('gui_running') || &t_Co == 256
  let g:lightline.active.left  = [ [ 'mode', 'paste' ],  [ 'fugitive' ], [ 'icon_filename' ] ]
  let g:lightline.active.right = [ [ 'filemodified', 'searchindex' ],  [ 'cursorinfo' ], [ g:rc_difffn ] ]
endif

" Have NERDTree ignore certain files and directories.
let g:NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$', '\.webp$', '\.webm$']
" More NERDTree options
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen=3
let g:NERDTreeMapUpdir='-'
let g:NERDTreeMapJumpNextSibling="J"
let g:NERDTreeMapJumpPrevSibling="K"
let g:NERDTreeShowLineNumbers=1

" }}}

" KEYBINDINGS {{{

nnoremap K <ESC>
nnoremap <esc> <Cmd>nohlsearch<CR><ESC>
nnoremap <up> <nop>|  nnoremap <down> <nop>
nnoremap <left> <nop>| nnoremap <right> <nop>

" kitty opacity compatibility
" let &t_ut=""

nnoremap L <Cmd>bn<CR>| nnoremap H <Cmd>bp<CR>

nnoremap <leader>et <Cmd>tab ter++kill=hup<CR>

" NERDTree Mappings
nnoremap <leader>ntt <Cmd>NERDTreeToggle<CR>
nnoremap <leader>ntf <Cmd>NERDTreeFocus<CR>
nnoremap <leader>ntc <Cmd>NERDTreeClose<CR>
nnoremap <leader>cyo <Cmd>call functions#CoverYourselfInOil()<CR>

" Fugitive mappings
nnoremap <leader>ga <Cmd>Git add %:p<CR><CR>
nnoremap <leader>gs <Cmd>Git status<CR>
nnoremap <leader>gc <Cmd>Git commit -v -q<CR>
nnoremap <leader>gt <Cmd>Git commit -v -q %:p<CR>
nnoremap <leader>gr <Cmd>Gread<CR>
nnoremap <leader>gw <Cmd>Gwrite<CR><CR>
nnoremap <leader>gl <Cmd>silent! Glog<CR><Cmd>bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Git move<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>

" GitGutter Mappings
nmap ]h <Plug>(GitGutterNextHunk)| nmap ghs <Plug>(GitGutterStageHunk)
nmap [h <Plug>(GitGutterPrevHunk)| nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

" Type jj to exit insert mode quickly.
inoremap jk <Esc>| inoremap jK <Esc>

imap <up> <C-O>gk| imap <down> <C-O>gj
vmap <up> gk| vmap <down> gj
nmap k gk| nmap j gj

" Press the space bar twice to type the : character in command mode.
nnoremap <leader><space> :

" Center the cursor vertically when moving to the next word during a search.
nnoremap * *zz|nnoremap g* g*zz
nnoremap # #zz|nnoremap g# g#zz

" Yank from cursor to the end of line.
nnoremap Y y$

" Render the ctags inside Vim.
if executable('ctags')
  nnoremap <F5> :w <cr>:!ctags -R .<cr><ESC>
endif

" You can split the window in Vim by typing :split or :vsplit.
nnoremap <c-h> <c-w>h| nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k| nnoremap <c-l> <c-w>l
nnoremap <c-w>h <c-w>h<c-w><bar>| nnoremap <c-w>j <c-w>j<c-w>_
nnoremap <c-w>l <c-w>l<c-w><bar>| nnoremap <c-w>k <c-w>k<c-w>_

" Move Lines
" nnoremap <a-j> :execute 'move .+' . v:count1<CR>==
" nnoremap <a-k> <cmd>execute 'move .-' . (v:count1 + 1)<cr>==
" inoremap <a-j> <esc><cmd>m .+1<cr>==gi
" inoremap <a-k> <esc><cmd>m .-2<cr>==gi
xnoremap <s-j> :<C-u>execute "'<,'>move '>+" . v:count1<cr>gv=gv
xnoremap <s-k> :<C-u>execute "'<,'>move '<-" . (v:count1 + 1)<cr>gv=gv

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
xnoremap < <gv|xnoremap > >gv

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
nnoremap <c-right> <c-w><| nnoremap <c-down> <c-w>-
nnoremap <c-left> <c-w>>|  nnoremap <c-up> <c-w>+

" replace the word under the cursor with whatever you want
nnoremap <leader>cw *``cgn| nnoremap <leader>cW #``cgN

" copy/paste the right way
nnoremap <leader>p "+p| nnoremap <leader>P "+P
nnoremap <leader>y "+y| nnoremap <leader>Y "+y$
xnoremap <leader>y "+y| xnoremap <Leader>p "+p

" Visual mode pressing * or # searches for the current selection
" from: https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
vnoremap <silent> * :<C-u>call functions#VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call functions#VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Enter Normal Mode
tnoremap <esc><esc> <c-\><c-n>

if executable("xsel") && $XDG_SESSION_TYPE !=# "wayland"

  autocmd VimLeave * call PreserveClipboard()
  nnoremap <silent> <c-z> :call PreserveClipboadAndSuspend()<cr>
  xnoremap <silent> <c-z> :<c-u>call PreserveClipboadAndSuspend()<cr>

" }}}

" VIMSCRIPT {{{

  function! PreserveClipboard()
    call system("xsel -ib", getreg('+'))
  endfunction
  function! PreserveClipboadAndSuspend()
    call PreserveClipboard()
    suspend
  endfunction

endif

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
  autocmd!
  autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype pug setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype hbs setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType lua setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

autocmd FileType Makefile setlocal noexpandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
  " Enable undofile and set undodir and backupdir
  let  s:dir = has('win32') ? '$APPDATA/Vim' : isdirectory($HOME.'/Library') ? '~/Library/Vim' : empty($XDG_STATE_HOME) ? '~/.local/state/vim' : '$XDG_DATA_HOME/vim'
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
augroup cursor_toggle
  autocmd!
  autocmd WinLeave * set nocursorline nocursorcolumn colorcolumn=0
  autocmd WinEnter * set cursorline nocursorcolumn colorcolumn=80
augroup END

" change directory to the current buffer's file's parent file
command CDC cd %:p:h

augroup restore_cursor
  autocmd!
  autocmd BufReadPost *
    \ let line = line("'\"")
    \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase'], &filetype) == -1
    \ |   execute "normal! g`\""
    \ | endif
augroup END

if has('termguicolors') && has('gui_running') || &t_Co == 256
  set termguicolors
endif

" If GUI version of Vim is running set these options.
if has('gui_running')
  set background=dark
  try | colorscheme dracula | catch | endtry

  " Set a custom font you have installed on your computer.
  " Syntax: <font_name>\ <weight>\ <size>
  set guifont=FiraCode\ Nerd\ Font\ Mono\ 13
  " Hide the toolbar.
  set guioptions-=T
  " Hide the the left-side scroll bar.
  set guioptions-=L
  " Hide the the right-side scroll bar.
  set guioptions-=r
  " Hide the the menu bar.
  set guioptions-=m
  " Hide the the bottom scroll bar.
  set guioptions-=b

  " Map the F4 key to toggle the menu, toolbar, and scroll bar.
  " <Bar> is the pipe character.
  " <CR> is the enter key.
  nnoremap <F9> <Cmd>if &guioptions=~#'mTr'<Bar>
                    \set guioptions-=mTr<Bar>
                    \else<Bar>
                    \set guioptions+=mTr<Bar>
                    \endif<CR><Esc>

endif

" }}}

" STATUS LINE & UI {{{

set fillchars+=vert:\\u2502
highlight VertSplit guibg='#21222C' guifg='#282A36'
highlight CursorColumn ctermfg=NONE ctermbg=NONE guibg='#21222c'
highlight CursorLine ctermfg=NONE ctermbg=NONE guibg='#21222c'

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=▲\ %F\ >\ %M\ %Y\ %R\ >

" Use a divider to separate the left side from the right side.
set statusline+=%=
" 
" Status line right side.
set statusline+=\ <\ %l:%c\ <\ @%p%%\ ▲

" Show the status on the second to last line.
set laststatus=2

" }}}

