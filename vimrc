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
set laststatus=2

call plug#begin('~/.vim/plugged')
Plug 'tweekmonster/gofmt.vim'
Plug 'itchyny/lightline.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'dylanaraps/wal.vim'
Plug 'valloric/youcompleteme'
call plug#end()
let mapleader=" "

set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
highlight LineNr ctermfg=yellow

let g:ycm_semantic_triggers =  {
  \   'c,cpp,objc,go,java,py': [ 're!\w{3}', '_' ],
  \ }

function Hi()
    execute 'echo "Hi"'
endfunction
augroup somethang
    autocmd!
    autocmd InsertEnter :execute 'echo "Hi"'
    autocmd BufReadPre *.txt set wrap linebreak nolist colorcolumn=122 textwidth=120 wrapmargin=120
    autocmd BufReadPre *.txt highlight ColorColumn ctermbg=0 guibg=lightgrey
augroup END

function Filename(filen)
    let length=strlen(filen)
    length=length - 4
    return filen[:length]
endfunction

function Runner()
    execute ':w'
    let suff=&filetype
    if suff == 'cpp'
        !echo Compiling && g++ % && echo "\nThe program is running now " && ./a.out
    elseif suff == 'c'
        !echo Compiling C&& gcc % && echo "\nThe program is running now " && ./a.out
    elseif suff == 'python'
       !echo "The snake has crawled\n" && python3 %
    elseif suff == 'tex'
        !echo "Writing....." && pdflatex % 
    elseif suff == 'sh'
        !echo "Bashing\n" && bash %
    "elseif suff == 'java'
        "echo Coffee has brewed
        "!javac %
        "let runfile=@%
        "runfile=call Filename(runfile)
        "!java runfile
    elseif suff == 'go'
        !echo "We are going\n" && go run %
    endif
endfunction

function Ender()
    :normal Go 
    :startinsert
endfunction

function Search_and_destroy()
    let destroyed=input("Enter the thing you want to destroy: ")
    let kaboom=input("Enter the replacer: ")
    execute ':%s/\<'.destroyed.'\>/'.kaboom.'/gci'
endfunction

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
