" load plugins

call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()


" ==================== Settings ====================

let mapleader=","

set clipboard=unnamed
set number

set splitright
set splitbelow

set ignorecase
set smartcase

set expandtab
set tabstop=4
set shiftwidth=4
set shiftround

set foldmethod=indent
set foldlevelstart=99 "start file with all folds opened

set hidden
set mouse=a
set formatoptions-=cro                             "disable auto comments on new lines
set undofile

highlight LineNr ctermfg=grey


" ==================== Mappings ====================

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <Tab> za
nnoremap <space> zz
nnoremap n nzzzv
nnoremap N Nzzzv
" leader
nmap <leader>w :w!<CR>
nmap <leader>q :q<CR>
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
nnoremap <leader>S :setlocal spell! spell?<CR>
nnoremap <leader>. :e $MYVIMRC<CR>

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

" Automatic toggling between line number modes
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
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


" ==================== FZF ====================
nnoremap <C-p> :FZF<CR>
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" ==================== netrw ====================
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'
nnoremap <C-n> :Lexplore<CR>
