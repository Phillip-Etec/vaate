vim9script

scriptencoding utf-8

if get(g:, 'rc_loaded_defs', false)
  finish
endif
g:rc_loaded_defs = true

def Vim9LightlineModified(): string
  return &ft =~# 'help\|vimfiler' ? '' : &modified ? '[+]' : &modifiable ? '' : '[-]'
enddef
def Vim9LightlineReadonly(): string
  return &ft !~? 'help\|vimfiler' && &readonly ? g:rc_readonly_glyph : ''
enddef
def g:Vim9LightlineFilename(): string
  return (&ft ==# 'vimfiler' ? vimfiler#get_status_string() :
     &ft ==# 'unite' ? unite#get_status_string() :
    expand('%:t') !=# '' ? expand('%:t') : '[No Name]') ..
    (Vim9LightlineModified() !=# '' ? ' ' .. Vim9LightlineModified() : '') ..
    (Vim9LightlineReadonly() !=# '' ? ' ' .. Vim9LightlineReadonly() : '')
enddef

def g:Vim9LightlineFugitive(): string
  if !empty(g:FugitiveHead())
    return (winwidth(0) > 70) ? g:rc_branch_glyph .. g:FugitiveHead() : g:rc_branch_glyph
  endif
  return ''
enddef

def g:Vim9FileTime(): string
  var fname = expand('%:t')
  if fname =~ 'NERD_tree'
    return ''
  endif
  var filename = expand("%")
  var cached_ftime  = getftime(filename)
  if cached_ftime ==# -1
    return strftime("%H:%M:%S")
  endif
  var msg = g:rc_clock_glyph
  var year = strftime("%Y", cached_ftime)
  var mandd = strftime("%m %d", cached_ftime)
  if year !=# strftime("%Y")
    return strftime("%b %d,%Y@%H:%M:%S", cached_ftime)
  elseif mandd !=# strftime("%m %d")
    return strftime("%b %d %H:%M:%S", cached_ftime)
  endif
  msg = (winwidth(0) > 70) ? msg .. strftime("%H:%M:%S", cached_ftime) : ((localtime() - cached_ftime) / 60) .. 'm'
  return msg
enddef

def g:Vim9GitStatus(): string
  if !empty(g:FugitiveStatusline())
    var [a,m,r] = g:GitGutterGetHunkSummary()
    return printf("%s%d %s%d %s%d", g:lightline#gitdiff#indicator_added, a,
                                    g:lightline#gitdiff#indicator_modified, m,
                                    g:lightline#gitdiff#indicator_deleted, r)
  else
    return ''
  endif
enddef

def g:Vim9GitAdded(): string
  if ! empty(g:FugitiveStatusline())
    var [a,m,r] = g:GitGutterGetHunkSummary()
    return (a > 0) ? printf("%s%d", g:lightline#gitdiff#indicator_added, a, ) : ''
  else
    return ''
  endif
enddef

def g:Vim9GitModified(): string
  if ! empty(g:FugitiveStatusline())
    var [a,m,r] = g:GitGutterGetHunkSummary()
    return (m > 0) ? printf("  %s%d", g:lightline#gitdiff#indicator_modified, m, ) : ''
  else
    return ''
  endif
enddef

def g:Vim9GitRemoved(): string
  if ! empty(g:FugitiveStatusline())
    var [a,m,r] = g:GitGutterGetHunkSummary()
    return (r > 0) ? printf("  %s%d", g:lightline#gitdiff#indicator_deleted, r, ) : ''
  else
    return ''
  endif
enddef

def g:Vim9Icon_Filename(): string
  return winwidth(0) > 70 ? ((strlen(&filetype) > 0) ?  g:WebDevIconsGetFileTypeSymbol()
                    .. ' ' .. g:Vim9LightlineFilename() .. Icon_Format() : g:Vim9LightlineFilename() )
                    : g:Vim9LightlineFilename()
enddef

def Icon_Format(): string
    return (winwidth(0) > 70 && &fileformat !=# 'unix') ?
                ( ' ' .. g:WebDevIconsGetFileFormatSymbol() .. ' ') : ''
  enddef

def g:Test(): string
    return g:rc_clock_glyph
enddef
