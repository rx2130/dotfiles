set clipboard=unnamed
set number relativenumber

set splitright
set splitbelow

set ignorecase
set smartcase

set expandtab
set tabstop=4
set shiftwidth=4
set shiftround

set noswapfile
set hidden
set mouse=a
set formatoptions-=cro                             "disable auto comments on new lines

" allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %

highlight LineNr ctermfg=grey

" Leader keys
let mapleader=","
nnoremap <leader><space> :nohlsearch<CR>
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
" Trim all whitespaces away
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
au FileType python nnoremap <buffer> <leader>r :exec '!python3' shellescape(@%, 1)<cr>

" Center the screen
nnoremap <space> zz

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

inoremap jk <esc>l
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A

tnoremap <Esc> <C-\><C-n>

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

au FocusLost * :wa              " Set vim to save the file on focus out.


" ==================== FZF ====================
set rtp+=/usr/local/opt/fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
nnoremap <C-p> :FZF<CR>


" ==================== netrw ====================
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'
nnoremap <leader>n :Lexplore<CR>
