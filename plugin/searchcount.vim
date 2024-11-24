" vim: sw=2 ts=2
vim9script

scriptencoding utf-8

if get(g:, 'rc_loaded_searchcount_vim9', false)
  finish
endif
g:rc_loaded_searchcount_vim9 = true

def g:SearchcountStatus(): string
  if ! v:hlsearch
    return ''
  endif
  try
    var result = searchcount({recompute: 1, maxcount: -1})
    if result.incomplete ==# 1
      return printf('[?/??]')
    elseif result.incomplete ==# 2
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
enddef
