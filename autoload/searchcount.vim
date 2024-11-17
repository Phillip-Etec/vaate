" MIT License. Copyright (c) 2013-2021 Bailey Ling et al.
" This extension is inspired by vim-anzu <https://github.com/osyo-manga/vim-anzu>.
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

if exists("g:rc_loaded_searchcount")
  finish
endif
let g:rc_loaded_searchcount = 1

function! searchcount#winwidth(...) abort
  return winwidth(get(a:000, 0, 0))
endfunction

function! searchcount#status() abort
  if ! v:hlsearch
    return ''
  endif
  try
    let result = searchcount(#{recompute: 1, maxcount: -1})
    "if empty(result) || result.total ==# 0
    "  return ''
    "endif
    if result.incomplete ==# 1     " timed out
      return printf('[?/??]')
    elseif result.incomplete ==# 2 " max count exceeded
      if result.total > result.maxcount &&
            \  result.current > result.maxcount
        return printf('[>%d/>%d]',
              \		    result.current, result.total)
      elseif result.total > result.maxcount
        return printf('[%d/>%d]',
              \		    result.current, result.total)
      endif
    endif
    return printf('[%d/%d]',
          \		result.current, result.total)
  catch
    return 'caught exception: ' .. v:exception
  endtry
endfunction
