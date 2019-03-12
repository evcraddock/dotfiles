set nocompatible

execute pathogen#infect()
syntax on
filetype plugin indent on
colorscheme solarized8 

let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
