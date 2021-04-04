syntax on 
set noshowmode
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
Plug 'itchyny/lightline.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'eemed/sitruuna.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'dylanaraps/wal.vim'
Plug 'valloric/youcompleteme'
call plug#end()
let mapleader=" "

set background=dark
colorscheme sitruuna
hi Normal guibg=NONE ctermbg=NONE
highlight LineNr ctermfg=yellow

"ycm completer
let g:ycm_semantic_triggers =  {
  \   'c,cpp,objc,go,java,py': [ 're!\w{3}', '_' ],
  \ }

"lightline colorscheme
let g:lightline = {
            \ 'colorscheme': 'sitruuna'
            \}

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
    endif
endfunction

augroup something
    autocmd!
    autocmd Filetype text set wrap linebreak nolist colorcolumn=122 textwidth=120 wrapmargin=120
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

"git and vim
nmap <leader>gs :G<CR>
nmap <leader>gcc :Gcommit<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>


"buffer movements and rearranging splits
map bfn :bn<CR>
map bfp :bp<CR>
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
nnoremap <leader>f :Files<CR>
nnoremap <leader>z :q!<CR>
nnoremap <leader>s :call Runner()<CR>
nnoremap <leader>ei :call Ender()<CR>
nnoremap <leader>sad :call Search_and_destroy()<CR>
