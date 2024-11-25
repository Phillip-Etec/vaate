scriptencoding utf-8

if exists("g:rc_loaded_functions")
  finish
endif
let g:rc_loaded_functions = 1

function! functions#disable_italic()
  let l:his = ''
  redir => his
  silent hi
  redir END
  let l:his = substitute(his, '\n\s\+', ' ', 'g')
  for line in split(his, "\n")
    if line !~ ' links to ' && line !~ ' cleared$'
      exe 'hi' substitute(substitute(line, ' xxx ', ' ', ''), 'italic', 'none', 'g')
    endif
  endfor
endfunction

command! DisableItalic call functions#disable_italic()

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! functions#VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! functions#CoverYourselfInOil()
    setlocal hidden
    if(&ft == 'startify' || expand("%:t") ==# '')
        let w:prev_nodes = ['', '']
        let w:prev_dir = ''
        exec "NERDTreeExplore"
        setlocal nohidden
        return
    endif
    let w:prev_nodes = (empty(get(w:, 'prev_nodes')))? ['', ''] : w:prev_nodes
    let l:cached_t = expand("%:t")
    let w:prev_nodes = (cached_t =~# 'NERD_tree' || cached_t ==# '')?
                \[ cached_t, w:prev_nodes[1] ] : [ cached_t, cached_t ]
    let w:prev_dir = (cached_t =~# 'NERD_tree' || cached_t ==# '')?
                \w:prev_dir : expand("%:p:h")
    exec "NERDTreeExplore " .. w:prev_dir
    if (w:prev_nodes[0] =~# 'NERD_tree' )
        exec "/" . w:prev_nodes[1]
        normal n
    else
        exec "/" . w:prev_nodes[0]
        normal n
    endif
"    nohlsearch
    pwd
    set nohidden
endfunction

function! functions#LightlineMode()
  let l:map = {
		    \ 'n' : 'N',
		    \ 'i' : 'I', 
        \ 'R' : 'R',
		    \ 'v' : 'v',
		    \ 'V' : 'V',
		    \ "\<C-v>": 'V-B',
		    \ 'c' : 'C',
		    \ 's' : 'S',
		    \ 'S' : 'S-L',
		    \ "\<C-s>": 'S-B',
		    \ 't': 'T',
		    \ }
  let l:fname = expand('%:t')
  return fname =~# '^__Tagbar__' ? 'Tagbar' :
        \ fname ==# 'ControlP' ? 'CtrlP' :
        \ fname ==# '__Gundo__' ? 'Gundo' :
        \ fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~# 'NERD_tree' ? 'NERDTree' :
        \ &ft ==# 'unite' ? 'Unite' :
        \ &ft ==# 'vimfiler' ? 'VimFiler' :
        \ &ft ==# 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : get(map, lightline#mode()[0], lightline#mode()[0])
endfunction

" source autoload/searchcount.vim
function! LightlineModified()
  return &ft =~# 'help\|vimfiler' ? '' : &modified ? '[+]' : &modifiable ? '' : '[-]'
endfunction
function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler' && &readonly ? g:rc_readonly_glyph : ''
endfunction
function! functions#LightlineFilename()
  return (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
        \ (&ft ==# 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft ==# 'unite' ? unite#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]') .
        \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
endfunction

function! functions#LightlineFugitive()
  if exists('*FugitiveHead') && !empty(FugitiveHead())
    return winwidth(0) > 70? g:rc_branch_glyph .. FugitiveHead() : g:rc_branch_glyph
  endif
  return ''
endfunction

function! functions#FileTime()
  let l:fname = expand('%:t')
  if fname =~# 'NERD_tree'
    return ''
  endif
  let l:filename=expand("%")
  let l:cached_ftime  = getftime(filename)
  if cached_ftime==# -1
    return strftime("%H:%M:%S")
  endif
  let l:msg=g:rc_clock_glyph
  let l:year=strftime("%Y",cached_ftime)
  let l:mandd=strftime("%m %d",cached_ftime)
  if year !=# strftime("%Y")
    return strftime("%b %d,%Y@%H:%M:%S",cached_ftime)
  elseif mandd !=# strftime("%m %d")
    return strftime("%b %d %H:%M:%S",cached_ftime)
  endif
  let l:msg = (winwidth(0) > 70)? msg..strftime("%H:%M:%S",cached_ftime) : ((localtime() - cached_ftime) / 60) .. 'm'
  return msg
endfunction

function! functions#GitStatus()
  if exists('*FugitiveStatusline') && exists('*GitGutterGetHunkSummary') && !empty(FugitiveStatusline())
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf("%s%d %s%d %s%d",g:lightline#gitdiff#indicator_added, a,
                                    \g:lightline#gitdiff#indicator_modified, m,
                                    \g:lightline#gitdiff#indicator_deleted, r)
  else
    return ''
  endif
endfunction

function! functions#GitAdded()
  if exists('*FugitiveStatusline') && exists('*GitGutterGetHunkSummary') && !empty(FugitiveStatusline())
    let [a,m,r] = GitGutterGetHunkSummary()
    return (a > 0)? printf("%s%d",g:lightline#gitdiff#indicator_added, a,) : ''
  else
    return ''
  endif
endfunction

function! functions#GitModified()
  if exists('*FugitiveStatusline') && exists('*GitGutterGetHunkSummary') && !empty(FugitiveStatusline())
    let [a,m,r] = GitGutterGetHunkSummary()
    return (m > 0)? printf("  %s%d",g:lightline#gitdiff#indicator_modified, m,) : ''
  else
    return ''
  endif
endfunction

function! functions#GitRemoved()
  if exists('*FugitiveStatusline') && exists('*GitGutterGetHunkSummary') && !empty(FugitiveStatusline())
    let [a,m,r] = GitGutterGetHunkSummary()
    return (r > 0)? printf("  %s%d",g:lightline#gitdiff#indicator_deleted, r,) : ''
  else
    return ''
  endif
endfunction

function! functions#Icon_Filename()
  return winwidth(0) > 70 ? (strlen(&filetype) ?  WebDevIconsGetFileTypeSymbol()
                    \.. ' ' .. LightlineFilename() .. Icon_Format() : LightlineFilename() ) 
                    \: LightlineFilename()
endfunction

function! Icon_Format()
    return (winwidth(0) > 70 && &fileformat !=# 'unix')? 
                \( ' ' .. WebDevIconsGetFileFormatSymbol() ..' ') : ''
  endfunction

