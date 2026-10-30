# cpp-header-detect.vim

## Description

Vim treats every `.h` file either as C or as C++. This plugin detects the
language of each header instead:

1. A source file with the same name next to the header decides: `foo.cpp`,
   `foo.cc`, `foo.cxx` or `foo.c++` make `foo.h` C++, `foo.c` makes it C.
2. Otherwise the first 100 lines are searched for C++ keywords like `class`,
   `namespace` or `template` and for constructs like `std::` or `<vector>`.
3. If nothing is found, the header is C.

## Installation

With [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'jclsn/cpp-header-detect.vim'
```

## Usage

Headers are detected when they are opened. Run `:CppHeaderDetect` to detect
the current buffer again, e.g. after writing the first C++ code into a new
header.

## Configuration

```vim
" Number of lines to search
let g:cpp_header_detect_lines = 100
" Filetype when no C++ is found
let g:cpp_header_detect_default = 'c'
" Extensions of C++ source files looked for next to the header
let g:cpp_header_detect_cpp_extensions = ['cpp', 'cc', 'cxx', 'c++']
" Additional whole words and patterns that mark a header as C++
let g:cpp_header_detect_keywords = ['concept']
let g:cpp_header_detect_patterns = ['\<Q_OBJECT\>']
```

See `:help cpp-header-detect` for details.
