" load plugins

call plug#begin('~/.vim/plugged')

if has("macunix")
    Plug '/usr/local/opt/fzf'
else
    Plug '/usr/share/doc/fzf/examples'
endif
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

call plug#end()


" ==================== Settings ====================

let mapleader=","

set clipboard=unnamed
set number
set relativenumber

set splitright
set splitbelow

set ignorecase
set smartcase

set expandtab
set tabstop=4
set shiftwidth=4
set shiftround

set hidden
set mouse=a
set undofile
set autowrite

highlight LineNr ctermfg=grey


" ==================== Mappings ====================

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <space> zz
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
" leader
nmap <leader>w :w!<CR>
nmap <leader>q :q<CR>
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
nnoremap <leader>S :setlocal spell! spell?<CR>
nnoremap <leader>. :e ~/dotfiles/.vimrc<CR>

inoremap jk <esc>l
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A
inoremap <C-f> <Right>
inoremap <C-b> <Left>

tnoremap <Esc> <C-\><C-n>

" allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %


" ==================== Autocommands ====================

" Set vim to save the file on focus out
autocmd FocusLost * :wa

" Automatically source .vimrc on save
augroup Vimrc
  autocmd! bufwritepost .vimrc source $MYVIMRC
augroup END

" Remember last cursor position
autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \	exe "normal! g`\"" |
        \ endif

" Run python file
au FileType python nnoremap <buffer> <leader>r :w<CR> :exec '!python3' shellescape(@%, 1)<CR>

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" no line number in Terminal
autocmd TermOpen * setlocal nonumber norelativenumber

" spell check for git commits
autocmd FileType gitcommit setlocal spell

" ==================== FZF ====================
nnoremap <C-p> :FZF<CR>
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" ==================== netrw ====================
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
nnoremap <C-n> :Lexplore<CR>


" ==================== Fugitive ====================
nnoremap <leader>gac :Git add %:p<CR>
nnoremap <leader>gc :Gcommit -q<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gb :Gblame<CR>
vnoremap <leader>gb :Gblame<CR>

