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
Plug 'altercation/vim-colors-solarized'

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

let g:solarized_termcolors=256
colorscheme solarized


" ==================== Mappings ====================

" Better split switching
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
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
nnoremap <leader>cz :e ~/dotfiles/.zshrc<CR>

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
autocmd! FocusLost * :wa

" Automatically source .vimrc on save
autocmd! BufWritePost .vimrc source $MYVIMRC

" Remember last cursor position
autocmd! BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" Run python file
autocmd! FileType python nnoremap <buffer> <leader>r :w<CR> :exec '!python3' shellescape(@%, 1)<CR>

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd! FileType help wincmd L

" spell check for git commits
autocmd! FileType gitcommit setlocal spell

" change current directory to file path
autocmd! BufEnter * silent! lcd %:p:h


" ==================== FZF ====================

nnoremap <C-p> :Files<CR>
nnoremap <C-n> :Buffers<CR>
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
autocmd FileType fzf nnoremap <buffer> <Esc> i<C-c>


" ==================== Terminal ====================

augroup neovim_terminal
    autocmd!

    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert

    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber

    " Enter Terminal-mode (insert) automatically
    autocmd BufEnter,BufNew * 
                \ if &buftype == 'terminal' |
                \   startinsert |
                \ endif
augroup END


" ==================== netrw ====================

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
nnoremap <leader>n :Lexplore<CR>


" ==================== Fugitive ====================

nnoremap <leader>ga :Git add %:p<CR>
nnoremap <leader>gc :Gcommit -q<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gb :Gblame<CR>
vnoremap <leader>gb :Gblame<CR>

