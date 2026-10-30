" Runs after Vim's own detection of *.h files and overrides it
autocmd BufRead,BufNewFile *.h call cpp_header_detect#Detect()
