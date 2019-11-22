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
Plug 'tpope/vim-unimpaired'
Plug 'nelstrom/vim-visual-star-search'
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'kassio/neoterm'
Plug 'yggdroot/indentline', { 'on': 'IndentLinesToggle' }
Plug 'thalesmello/tabfold'
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
set cursorline
set noshowmode
set inccommand=nosplit

let g:solarized_termcolors=256
colorscheme solarized


" ==================== Mappings ====================

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap Y y$
nnoremap Q @q
nnoremap <space> zz
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap <C-o> <C-o>zzzv
nnoremap <C-i> <C-i>zzzv
" leader
nnoremap <leader>w :w!<CR>
nnoremap <leader>q :Sayonara<CR>
nnoremap <leader>Q :qa<CR>
nnoremap <leader>d "_d
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
nnoremap <leader>S :setlocal spell! spell?<CR>
nnoremap <leader>N :enew<CR>
nnoremap <leader>. :e ~/dotfiles/.vimrc<CR>
nnoremap <leader>cz :e ~/dotfiles/.zshrc<CR>

inoremap <C-a> <esc>I
inoremap <C-e> <esc>A
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-d> <Right><BS>

" allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %


" ==================== Autocommands ====================

" Set vim to save the file on focus out
autocmd! FocusLost * :wa

" Automatically source .vimrc on save
autocmd! BufWritePost .vimrc nested source $MYVIMRC

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
nnoremap <leader>f :GFiles?<CR>
nnoremap <leader>F :GFiles<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>r :BTags<CR>
nnoremap <leader>R :Tags<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <leader>' :Marks<CR>
nnoremap <leader>C :Commands<CR>
nnoremap <leader>: :History:<CR>
nnoremap <leader>s :Filetypes<CR>
nnoremap <leader>H :Helptags!<CR>
nnoremap <leader>M :Maps<CR>
nnoremap <leader>/ :Rg<Space>
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler nonumber norelativenumber
            \| autocmd BufLeave <buffer> set laststatus=2 ruler
autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
autocmd FileType fzf tunmap <buffer> <Esc>


" ==================== Terminal ====================

let g:neoterm_autoscroll = 1
nnoremap <leader>T :bel Tnew<CR>
nnoremap <leader>t :vert Tnew<CR>


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


" ==================== lightline ====================

let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ }
