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

    " Highlight cursor line underneath the cursor horizontally.
    set cursorline

    " Highlight cursor line underneath the cursor vertically.
    set cursorcolumn

    " Set shift width to 4 spaces.
    set shiftwidth=4

    " Set tab width to 4 columns.
    set tabstop=4

    " Use space characters instead of tabs.
    set expandtab

    " Do not save backup files.
    " set nobackup

    " Do not let cursor scroll below or above N number of lines when scrolling.
    set scrolloff=6

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

    " Set the commands to save in history default number is 20.
    set history=128

    " Enable auto completion menu after pressing TAB.
    set wildmenu

    " Make wildmenu behave like similar to Bash completion.
    set wildmode=list:longest

    " There are certain files that we would never want to edit with Vim.
    " Wildmenu will ignore files with these extensions.
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

    " kitty opacity compatibility
    let &t_ut=""

    " set default colorscheme
    " colorscheme desert

    " PLUGINS ---------------------------------------------------------------- {{{
    "
    " call plug#begin()
    " The default plugin directory will be as follows:
    "   - Vim (Linux/macOS): '~/.vim/plugged'
    "   - Vim (Windows): '~/vimfiles/plugged'
    "   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
    " You can specify a custom plugin directory by passing it as the argument
    "   - e.g. `call plug#begin('~/.vim/plugged')`
    "   - Avoid using standard Vim directory names like 'plugin'

    " Make sure you use single quotes

    " Plug 'dracula/vim', { 'as': 'dracula' }

    " Plug 'vim-airline/vim-airline'

    " Plug 'tpope/vim-surround'

    " Plug 'preservim/nerdtree'

    " Plug 'vim-airline/vim-airline-themes'


    " Initialize plugin system
    " - Automatically executes `filetype plugin indent on` and `syntax enable`.
    " call plug#end()
    " You can revert the settings after the call like so:
    "   filetype indent off   " Disable file-type-specific indentation
    "   syntax off            " Disable syntax highlighting
    " }}}
    "
    
    execute pathogen#infect()
    
    set background=dark
    nnoremap <leader>\ ``

    nnoremap <leader>nt :NERDTreeToggle<CR>
    nnoremap <leader>nf :NERDTreeFocus<CR>
    nnoremap <leader>nc :NERDTreeClose<CR>



    " Press \p to print the current file to the default printer from a Linux operating system.
    " View available printers:   lpstat -v
    " Set default printer:       lpoptions -d <printer_name>
    " <silent> means do not display output.
    " nnoremap <silent> <leader>p :%w !lp<CR>

    " Type jj to exit insert mode quickly.
    inoremap jk <Esc>

    " Press the space bar to type the : character in command mode.
    nnoremap <space> :

    " Pressing the letter o will open a new line below the current one.
    " Exit insert mode after creating a new line above or below the current line.
    nnoremap o o<esc>
    nnoremap O O<esc>

    " Center the cursor vertically when moving to the next word during a search.
    nnoremap n nzz
    nnoremap N Nzz

    " Yank from cursor to the end of line.
    nnoremap Y y$

    " Map the F5 key to run a Python script inside Vim.
    " We map F5 to a chain of commands here.
    " :w saves the file.
    " <CR> (carriage return) is like pressing the enter key.
    " !clear runs the external clear screen command.
    " !python3 % executes the current file with Python.
    nnoremap <F5-p> :w <CR>:!clear <CR>:!python3 % <CR>

    " You can split the window in Vim by typing :split or :vsplit.
    " Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
    nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
" nnoremap <F3> :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
" let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=1024
endif

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END

" let g:airline_theme='base16_dracula'

" If GUI version of Vim is running set these options.
if has('gui_running')

    " Set the background tone.
    set background=dark

    " Set the color scheme.
    colorscheme dracula

    " Set a custom font you have installed on your computer.
    " Syntax: <font_name>\ <weight>\ <size>
    set guifont=FiraCode\ Nerd\ Font\ Mono\ weight=450\ 12

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
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR><Esc>

    " Change airline trail
    let g:airline_left_sep = '»'
    let g:airline_left_sep = ''
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '' 
    
    "let g:airline_theme='dracula'

endif

" }}}
"

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=
" 
" Status line right side.
set statusline+=\ \ %l,%c\ @%p%%

" Show the status on the second to last line.
set laststatus=2

" }}}
"
