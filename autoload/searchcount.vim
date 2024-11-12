" MIT License. Copyright (c) 2013-2021 Bailey Ling et al.
" This extension is inspired by vim-anzu <https://github.com/osyo-manga/vim-anzu>.
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

function! searchcount#winwidth(...) abort
  let nr = get(a:000, 0, 0)
  " When statusline is on top, or using global statusline for Neovim
  " always return the number of columns
  if get(g:, 'airline_statusline_ontop', 0) || &laststatus > 2
    return &columns
  else
    return winwidth(nr)
  endif
endfunction

function! searchcount#shorten(text, winwidth, minwidth, ...)
  if searchcount#winwidth() < a:winwidth && len(split(a:text, '\zs')) > a:minwidth
    if get(a:000, 0, 0)
      " shorten from tail
      return '…'.matchstr(a:text, '.\{'.a:minwidth.'}$')
    else
      " shorten from beginning of string
      return matchstr(a:text, '^.\{'.a:minwidth.'}').'…'
    endif
  else
    return a:text
  endif
endfunction

function! s:search_term()
  let show_search_term = get(g:, 'searchcount#show_search_term', 1)
  let search_term_limit = get(g:, 'searchcount#search_term_limit', 8)

  if show_search_term == 0
    return ''
  endif
  " shorten for all width smaller than 300 (this is just a guess)
  " this uses a non-breaking space, because it looks like
  " a leading space is stripped :/
  return "\ua0" .  '/' . searchcount#shorten(getreg('/'), 300, search_term_limit)
endfunction

function! searchcount#status() abort
  if ! &hlsearch
    return ''
  endif
  try
    let result = searchcount(#{recompute: 1, maxcount: -1})
    if empty(result) || result.total ==# 0
      return ''
    endif
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
