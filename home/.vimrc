set nocompatible
set number

execute pathogen#infect()
syntax on
filetype plugin on
filetype indent on
let &t_Co=256
colorscheme solarized8 

let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

vmap <C-c> :<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -selection c<CR>
map <Insert> :set paste<CR>i<CR><CR><Esc>k:.!xclip -o<CR>JxkJx:set nopaste<CR>
map <F6> :NERDTreeToggle<CR>
map <F5> :MarkdownPreview<CR>

set spell spelllang=en_us
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 1

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" For ledger
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
let g:ledger_maxwidth = 120
let g:ledger_fold_blanks = 1
function LedgerSort()
    :%! ledger -f - print --sort 'date, amount'
    :%LedgerAlign
endfunction
command LedgerSort call LedgerSort()

set rtp+='~/.fzf'

let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc
" Only lints file types in here (so won't lint Go files and whatnot)
let g:ale_linters_explicit = 1
let g:ale_linters = {'javascript': ['eslint'],'typescript': ['eslint'],'typescriptreact': ['tsserver','eslint', 'tslint']}
let g:ale_fixers = {'javascript': ['eslint'],'typescript': ['eslint','tslint'],'typescriptreact': ['eslint','tslint']}
" " Format on save
let g:ale_fix_on_save = 1

let g:coc_global_extensions = [ 'coc-prettier', 'coc-tsserver' ]

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

nnoremap K :ALEHover<CR>
autocmd FileType javascript map <buffer> gd :ALEGoToDefinition<CR>
autocmd FileType typescript map <buffer> gd :ALEGoToDefinition<CR>
autocmd FileType typescriptreact map <buffer> gd :ALEGoToDefinition<CR>
" " gr -> find usages of type/function/variable
nnoremap <silent> gr :ALEFindReferences<CR>

