" Variables {{{1
let s:doge = [
      \ '░░░░░░░░░▄░░░░░░░░░░░░░░▄░░░░',
      \ '░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌░░░',
      \ '░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐░░░',
      \ '░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐░░░',
      \ '░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐░░░',
      \ '░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌░░░', 
      \ '░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌░░',
      \ '░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐░░',
      \ '░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌░',
      \ '░▌░▒▄██▄▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌░',
      \ '▀▒▀▐▄█▄█▌▄░▀▒▒░░░░░░░░░░▒▒▒▐░',
      \ '▐▒▒▐▀▐▀▒░▄▄▒▄▒▒▒▒▒▒░▒░▒░▒▒▒▒▌',
      \ '▐▒▒▒▀▀▄▄▒▒▒▄▒▒▒▒▒▒▒▒░▒░▒░▒▒▐░',
      \ '░▌▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒░▒░▒░▒░▒▒▒▌░',
      \ '░▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▒▄▒▒▐░░',
      \ '░░▀▄▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▄▒▒▒▒▌░░',
      \ '░░░░▀▄▒▒▒▒▒▒▒▒▒▒▄▄▄▀▒▒▒▒▄▀░░░',
      \ '░░░░░░▀▄▄▄▄▄▄▀▀▀▒▒▒▒▒▄▄▀░░░░░',
      \ '░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▀▀░░░░░░░░',
      \ ]

let s:quotes = exists('g:startify_custom_header_quotes')
      \ ? g:startify_custom_header_quotes
      \ : [
      \ [ '    Wow            very vim            much modal         keep ur hands on teh kyebaord                  so stratify' ]
      \ ]

" Function: s:get_random_offset {{{1
function! s:get_random_offset(max) abort
  return str2nr(matchstr(reltimestr(reltime()), '\.\zs\d\+')[1:]) % a:max
endfunction

" Function: s:draw_box {{{1
function! s:draw_box(lines) abort
  let longest_line = max(map(copy(a:lines), 'len(v:val)'))
  let topbottom = '*'. repeat('-', longest_line + 2) .'*'
  let lines = [topbottom]
  for l in a:lines
    let offset = longest_line - len(l)
    let lines += ['| '. l . repeat(' ', offset) .' |']
  endfor
  let lines += [topbottom]
  return lines
endfunction

" Function: #quote {{{1
function! startify#fortune#quote() abort
  return s:quotes[s:get_random_offset(len(s:quotes))]
endfunction

" Function: #boxed {{{1
function! startify#fortune#boxed() abort
  let wrapped_quote = []
  let quote = startify#fortune#quote()
  for line in quote
    let wrapped_quote += split(line, '\%50c.\{-}\zs\s', 1)
  endfor
  let wrapped_quote = s:draw_box(wrapped_quote)
  return wrapped_quote
endfunction

" Function: #dogesay {{{1
function! startify#fortune#dogesay() abort
  let boxed_quote = startify#fortune#boxed()
  let boxed_quote += s:doge
  return map(boxed_quote, '"   ". v:val')
endfunction
