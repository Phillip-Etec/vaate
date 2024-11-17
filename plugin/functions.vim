vim9script

scriptencoding utf-8

#if get(g:, 'rc_loaded_defs', false)
#  finish
#endif
#g:rc_loaded_defs = true

def Vim9LightlineModified(): string
  return &ft =~# 'help\|vimfiler' ? '' : &modified ? '[+]' : &modifiable ? '' : '[-]'
enddef
def Vim9LightlineReadonly(): string
  return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
enddef
def g:Vim9LightlineFilename(): string
  return (Vim9LightlineReadonly() !=# '' ? Vim9LightlineReadonly() .. ' ' : '') ..
    (&ft ==# 'vimfiler' ? vimfiler#get_status_string() :
     &ft ==# 'unite' ? unite#get_status_string() :
    expand('%:t') !=# '' ? expand('%:t') : '[No Name]') ..
    (Vim9LightlineModified() !=# '' ? ' ' .. Vim9LightlineModified() : '')
enddef

def g:Test(): string
    var glyph = g:clock_glyph
    return glyph
enddef
