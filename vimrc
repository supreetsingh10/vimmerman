syntax on 
set cursorline
set noshowmode
set shell=/bin/zsh
set hidden
set showcmd
set updatetime=300
set shortmess+=c
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set wildmenu
set completeopt-=preview

" automatically installs the vimplug if it does not exist. 
" May require a vim restart
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
"Plug 'jremmen/vim-ripgrep'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'ashfinal/vim-colors-paper'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
call plug#end()
let mapleader=" "
set termwinkey=<C-L>

"inbuilt autocomplete for HTML and langs. 
filetype plugin on
au Filetype php setl ofu=phpcomplete#CompletePHP
au Filetype ruby,eruby setl ofu=rubycomplete#ComleteRUBY
au Filetype html,xhtml setl ofu=htmlcomplete#CompleteHTML
au Filetype css setl omnifunc=csscomplete#CompleteCSS


set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
let g:gruvbox_contrast_dark = 'hard'


highlight LineNr ctermfg=Green
highlight htmlArgs cterm=italic
highlight Comment gui=italic cterm=italic ctermfg=grey


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline#extensions#lsp#enabled = 1
let g:airline_left_sep = ''
let g:airline_powerline_fonts = 1
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.space = ' '
let g:airline#extensions#ycm#enabled = 1
let airline#extensions#syntastic#stl_format_err = '%E{[%fe(#%e)]}'
let g:airline#extensions#ycm#error_symbol = 'E:'
let airline#extensions#syntastic#stl_format_warn = '%W{[%fw(#%w)]}'
let g:airline#extensions#ycm#warning_symbol = 'W:'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#buf_label_first = 1
let g:airline#extensions#tabline#show_tab_nr = 1


let g:fzf_preview_window = ['right,50%', 'ctrl-/']

" Preview window is hidden by default. You can toggle it with ctrl-/.
" It will show on the right with 50% width, but if the width is smaller
" than 70 columns, it will show above the candidate list

let g:fzf_preview_bash = '/usr/bin/bash'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

function Vimg_this_dir()
    let l:pattern = expand("<cword>")
    let l:dirs = getcwd()
    execute 'vimgrep ' l:pattern l:dirs."/*"
endfunction

function Vimg_this_file() 
    let l:pattern = expand("<cword>")
    execute 'vimgrep ' l:pattern." %"
endfunction

function Vimg_root_dir()
    let l:pattern = expand("<cword>")
    execute 'vimgrep ' l:pattern "**/*"
endfunction

function Vimg_all_dirs()
    let l:pattern = expand("<cword>")
    let l:dirs = expand("%:h/")
    execute 'vimgrep ' l:pattern l:dirs."/**/*"
endfunction

function RipperSearch() 
    let l:word = expand('<cword>')
    execute 'Rg ' l:word
endfunction

function Runner()
    execute ':w'
    let suff=&filetype
    if suff == 'cpp'
        !echo Compiling && g++ % && echo "The program is running now " && ./a.out
    elseif suff == 'c'
        !echo Compiling C && gcc % && echo "The program is running now " && ./a.out
    elseif suff == 'python'
       !echo "The snake has crawled" && python3 %
    elseif suff == 'tex'
        !echo "Writing....." && pdflatex % 
    elseif suff == 'sh'
        !echo "Bashing" && bash %
    elseif suff == 'go'
        !echo "We are going" && go run %
    elseif suff == 'perl'
        !echo "See the perl" && perl %
    elseif suff == 'latex'
        !echo "tex time..." && pdflatex %
    elseif suff == 'javascript'
        !echo "Jabha Schript" && node %
    elseif suff == 'yaml'
        !echo "We playing" && ansible-playbook %
    elseif suff == 'rust'
        let l:x = expand('%:p')
        execute '!rustc ' l:x
    endif
endfunction

function Ender()
    :normal Go 
    :startinsert
    :normal zz
endfunction

function Search_and_destroy()
   let destroyed=input("Enter the thing you want to destroy: ")
   let kaboom=input("Enter the replacer: ")
    execute ':%s/\<'.destroyed.'\>/'.kaboom.'/gci'
endfunction

function BufferJumper()
    let buff=input("Enter the buffer number you want to go to: ")
    execute ':buffer '.buff
endfunction

function QFListBuffer()
    let buff=getqflist()
endfunction

function FRunner() 
    let lookup=input("Enter the directory: ")
    :execute ':Files' .lookup
endfunction

function Presentsearch() 
    let dir=getcwd()
    execute ':Files'.dir
endfunction


augroup ansible_vim
    au!
    autocmd!
    autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
augroup END

augroup something
    au!
    autocmd!
    autocmd Filetype markdown set spell wrap linebreak nolist colorcolumn=122 textwidth=120 wrapmargin=120
    autocmd Filetype text set spell wrap linebreak nolist colorcolumn=122 textwidth=120 wrapmargin=120
    autocmd Filetype latex set spell 
augroup END

"git and vim
nmap <leader>gs :G<CR>


"buffer movements and rearranging splits
map <C-Right> :bn<CR>
map <C-Left> :bp<CR>
map bu :buffers<CR>
map mvk :<C-w> <bar> :wincmd K<CR>
map mvj :<C-w> <bar> :wincmd J<CR>
map mvh :<C-w> <bar> :wincmd H<CR>
map mvl :<C-w> <bar> :wincmd L<CR>

"Inbuilt terminal
nnoremap <leader>tit :vertical botright terminal<CR>
nnoremap <leader>tty :below terminal <CR>

"vim git
nnoremap <leader>G :Git <CR>

"vimgrep remaps 
set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

nnoremap <leader>Rg :Rg <CR>
nnoremap <leader>Rw :call RipperSearch()<CR>
nnoremap <leader>va :call Vimg_all_dirs() <CR>
nnoremap <leader>vt :call Vimg_this_dir() <CR>
nnoremap <leader>vr :call Vimg_root_dir() <CR> 
nnoremap <leader>vf :call Vimg_this_file() <CR>

"Quick fix Lists
map <C-k> :cprevious <CR> 
map <C-j> :cnext <CR>
map <C-q> :copen <CR>
map <C-l> :lopen <CR>
map <C-n> :lnext <CR> 
map <C-p> :lprevious <CR>

"remaps for the commands
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <silent><Leader>+ :vertical resize +5<CR>
nnoremap <silent><Leader>- :vertical resize -5<CR>

"Coc completer 
inoremap <expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
nnoremap <leader>hv :call CocActionAsync('definitionHover') <CR>
nnoremap <silent><leader>jd :call CocActionAsync('jumpDefinition') <CR>
nnoremap <silent><leader>js :call CocActionAsync('jumpDefinition', 'vsplit') <CR>
nnoremap <silent><leader>jl :call CocActionAsync('jumpDeclaration') <CR>
nnoremap <silent><leader>jil :call CocActionAsync('jumpImplementation') <CR>
nnoremap <silent><leader>ot :call CocActionAsync('organizeImport') <CR>
nnoremap <silent><leader>qf :call CocActionAsync('doQuickFix') <CR>
highlight CocErrorHighlight ctermfg=Red 
highlight CocErrorVirtualText ctermfg=Red

nnoremap <leader>fz :Files / <CR>
nnoremap <leader>fcd :call Presentsearch()<CR>
nnoremap <leader>fzf :call FRunner()<CR>
nnoremap <leader>z :q!<CR>
nnoremap <leader>s :call Runner()<CR>
nnoremap <leader>ei :call Ender()<CR>
nnoremap <leader>sad :call Search_and_destroy()<CR>
nnoremap <leader>bu :call BufferJumper()<CR>
