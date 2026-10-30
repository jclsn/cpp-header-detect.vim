" Author        : Jan Claussen
" License       : MIT
" Description   : Detect whether a .h file is C or C++

let s:keywords = [
      \   'class',
      \   'constexpr',
      \   'decltype',
      \   'explicit',
      \   'final',
      \   'friend',
      \   'mutable',
      \   'namespace',
      \   'noexcept',
      \   'operator',
      \   'override',
      \   'private',
      \   'protected',
      \   'public',
      \   'static_assert',
      \   'template',
      \   'this',
      \   'typename',
      \   'using',
      \   'virtual',
      \ ]

" Not bound to word boundaries
let s:patterns = [
      \   '<[A-Za-z_]\+>',
      \   '\<std::[a-zA-Z_]',
      \ ]

" Returns 'c' or 'cpp' for the header in buffer {bufnr}
function! cpp_header_detect#Guess(bufnr) abort
  " A source file with the same name decides
  let l:base = fnamemodify(bufname(a:bufnr), ':p:r')
  for l:ext in get(g:, 'cpp_header_detect_cpp_extensions', ['cpp', 'cc', 'cxx', 'c++'])
    if filereadable(l:base . '.' . l:ext)
      return 'cpp'
    endif
  endfor
  if filereadable(l:base . '.c')
    return 'c'
  endif

  " Otherwise look for C++ constructs at the top of the file
  let l:lines = get(g:, 'cpp_header_detect_lines', 100)
  let l:content = join(getbufline(a:bufnr, 1, l:lines), "\n")

  let l:keywords = s:keywords + get(g:, 'cpp_header_detect_keywords', [])
  let l:patterns = s:patterns + get(g:, 'cpp_header_detect_patterns', [])
  let l:regex = '\C\<\%(' . join(l:keywords, '\|') . '\)\>'
  if !empty(l:patterns)
    let l:regex .= '\|' . join(l:patterns, '\|')
  endif

  return l:content =~# l:regex ? 'cpp' : get(g:, 'cpp_header_detect_default', 'c')
endfunction

" Sets the filetype of the current buffer. :setf does nothing after Vim's own
" filetype detection already ran, so set it directly, but only when it changes
" to not run the FileType autocommands again.
function! cpp_header_detect#Detect() abort
  let l:filetype = cpp_header_detect#Guess(bufnr('%'))
  if &filetype !=# l:filetype
    let &l:filetype = l:filetype
  endif
endfunction
