" load plugins

call plug#begin('~/.vim/plugged')

if has("macunix")
    Plug '/usr/local/opt/fzf'
else
    Plug '/usr/share/doc/fzf/examples'
endif
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tommcdo/vim-exchange'
Plug 'myusuf3/numbers.vim'
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'kassio/neoterm'
Plug 'yggdroot/indentLine', { 'on': 'IndentLinesToggle' }
Plug 'thalesmello/tabfold'
Plug 'raimondi/delimitmate'
Plug 'wellle/targets.vim'
Plug 'andrewradev/splitjoin.vim'
Plug 'thinca/vim-quickrun'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
" mimic unimpaired toggling option
nnoremap yod :IndentLinesToggle<CR>
" leader
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>w :w!<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
" allow saving of files as sudo
nnoremap <leader>W!! :w !sudo tee > /dev/null %
nnoremap <leader>q :Sayonara<CR>
nnoremap <leader>Q :qa<CR>
nnoremap <leader>d "_d
nnoremap <leader>. :e ~/dotfiles/.vimrc<CR>
nnoremap <leader>Cz :e ~/dotfiles/.zshrc<CR>

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-p> <Up>
inoremap <C-n> <Down>

cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>

vnoremap Q :norm @q<CR>


" ==================== Autocommands ====================

" Set vim to save the file on focus out
autocmd! FocusLost * silent! :wa

" Automatically source .vimrc on save
autocmd! BufWritePost .vimrc nested source $MYVIMRC

" Remember last cursor position
autocmd! BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" open help vertically
autocmd! FileType help wincmd L

" spell check for git commits
autocmd! FileType gitcommit setlocal spell

" change current directory to file path
autocmd! BufEnter * silent! lcd %:p:h

" Resize panes when window/terminal gets resize
autocmd! VimResized * wincmd =

" prevent unintended write
autocmd BufReadPost fugitive:///*//0/* setlocal nomodifiable readonly
autocmd BufReadPost .vim/plugged/* setlocal nomodifiable readonly


" ==================== FZF ====================

nnoremap <C-p> :Files<CR>
nnoremap <leader>f :GFiles?<CR>
nnoremap <leader>F :GFiles<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
" nnoremap <leader>r :BTags<CR>
nnoremap <leader>R :Tags<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <leader>' :Marks<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>: :History:<CR>
nnoremap <leader>s :Filetypes<CR>
nnoremap <leader>H :Helptags<CR>
nnoremap <leader>M :Maps<CR>
nnoremap <leader>/ :Rg<CR>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler nonumber norelativenumber
            \| autocmd BufLeave <buffer> set laststatus=2 ruler
autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
autocmd FileType fzf tunmap <buffer> <Esc>


" ==================== Terminal ====================

let g:neoterm_autoscroll = 1
nnoremap <leader>T :bel Ttoggle<CR>
nnoremap <leader>t :vert Ttoggle<CR>


" ==================== netrw ====================

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
nnoremap <leader>n :Lexplore<CR>


" ==================== Fugitive ====================

nnoremap <leader>gg :Gstatus<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gc :Gcommit -q<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gf :Gfetch<CR>
nnoremap <leader>gl :Gpull<CR>
nnoremap <leader>gb :Gblame<CR>
vnoremap <leader>gb :Gblame<CR>
" via FZF
nnoremap <leader>gh :Commits<CR>
nnoremap <leader>gH :BCommits<CR>

" ==================== lightline ====================

let g:lightline = {
            \ 'colorscheme': 'solarized',
            \   'active': {
            \     'left': [['mode', 'paste'], ['filename', 'readonly', 'modified']],
            \     'right': [['lineinfo'], ['percent'], ['filetype']]
            \   },
            \ }
" easier to observe if vim active
autocmd FocusGained * call setwinvar(winnr(), '&statusline', lightline#statusline(0))
autocmd FocusLost   * call setwinvar(winnr(), '&statusline', lightline#statusline(1))


" ==================== delimitMate ====================

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1


" ==================== coc.vim ====================

" You will have bad experience for diagnostic messages when it's default 4000.
" set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <C-Space>for trigger completion
inoremap <expr> <C-Space> coc#refresh()

" Use <cr> to confirm completion
imap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<Plug>delimitMateCR"

" Close the preview window when completion is done.
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" ==================== numbers.vim ====================

let g:numbers_exclude = ['help', 'neoterm']


" ==================== buftabline ====================

let g:buftabline_show = 1
let g:buftabline_numbers = 2
let g:buftabline_indicators = 1

nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(-1)
