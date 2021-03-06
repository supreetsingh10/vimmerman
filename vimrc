syntax on 
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
"set laststatus=2

call plug#begin('~/.vim/plugged')
Plug 'tweekmonster/gofmt.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'eemed/sitruuna.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'dylanaraps/wal.vim'
Plug 'valloric/youcompleteme'
Plug 'sainnhe/sonokai'
call plug#end()
let mapleader=" "
set termwinkey=<C-L>

"airline 
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
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

"sonokai
if has('termguicolors')
  set termguicolors
endif

"let g:sonokai_enable_italic = 0
let g:sonokai_style = 'andromeda'
let g:sonokai_transparent_background = 1
let g:sonokai_show_eob = 0
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_better_performance = 1
"set background=dark
colorscheme sonokai
hi Normal guibg=NONE ctermbg=NONE

"gruvbox configs 
"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_hls_cursor = 'green'

"highlight LineNr ctermfg=Green
highlight Comment gui=italic cterm=italic ctermfg=grey
"ycm completer
let g:ycm_semantic_triggers =  {
  \   'c,cpp,objc,go,java,py': [ 're!\w{3}', '_' ],
  \ }
let g:ycm_echo_current_diagnostic=0
let g:ycm_max_num_candidates = 20
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'

function Runner()
    execute ':w'
    let suff=&filetype
    if suff == 'cpp'
        !echo Compiling && g++ % && echo "The program is running now " && ./a.out
    elseif suff == 'c'
        !echo Compiling C&& gcc % && echo "The program is running now " && ./a.out
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
    elseif suff == 'javascript'
        !echo "Jabha Schript" && node %
    endif
endfunction

augroup something
    autocmd!
    autocmd Filetype markdown set spell wrap linebreak nolist colorcolumn=122 textwidth=120 wrapmargin=120
    autocmd Filetype text set spell wrap linebreak nolist colorcolumn=122 textwidth=120 wrapmargin=120 
    autocmd Filetype text colorscheme sitruuna
augroup END

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

"git and vim
nmap <leader>gs :G<CR>
nmap <leader>tit :vertical botright terminal<CR>


"buffer movements and rearranging splits
map bfn :bn<CR>
map bfp :bp<CR>
map bu :buffers<CR>
map mvk :<C-w> <bar> :wincmd K<CR>
map mvj :<C-w> <bar> :wincmd J<CR>
map mvh :<C-w> <bar> :wincmd H<CR>
map mvl :<C-w> <bar> :wincmd L<CR>

"remaps for the commands
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <silent><Leader>+ :vertical resize +5<CR>
nnoremap <silent><Leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>jd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>rr :YcmCompleter RefractorRename<space>
nnoremap <leader>f :FZF ~<CR>
nnoremap <leader>cd :Files<CR>
nnoremap <leader>z :q!<CR>
nnoremap <leader>s :call Runner()<CR>
nnoremap <leader>ei :call Ender()<CR>
nnoremap <leader>sad :call Search_and_destroy()<CR>
nnoremap <leader>tty :below terminal <CR><C-\><C-N> <CR> below resize -10<CR>
nnoremap <leader>bu :call BufferJumper()<CR>
