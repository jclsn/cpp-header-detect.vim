" Author        : Jan Claussen
" License       : MIT
" Description   : Detect whether a .h file is C or C++

if exists('g:loaded_cpp_header_detect')
  finish
endif
let g:loaded_cpp_header_detect = 1

command! -bar CppHeaderDetect call cpp_header_detect#Detect()
