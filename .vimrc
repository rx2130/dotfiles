" vim: set fdm=marker fmr={{{,}}} fdl=99 :

" load plugins {{{

call plug#begin('~/.vim/plugged')

" Vim enhancements
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'yggdroot/indentLine', { 'on': 'IndentLinesToggle' }
Plug 'scrooloose/nerdtree'
Plug 'kassio/neoterm'
Plug 'thalesmello/tabfold'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-sleuth'
Plug 'chiel92/vim-autoformat'
Plug 'christoomey/vim-tmux-navigator'

" Edit enhancements
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'nelstrom/vim-visual-star-search'
Plug 'raimondi/delimitmate'
Plug 'godlygeek/tabular'

" GUI enhancements
Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'haya14busa/is.vim'
Plug 'gruvbox-community/gruvbox'

" Fuzzy finder
if has("macunix")
    Plug '/usr/local/opt/fzf'
else
    Plug '/usr/share/doc/fzf/examples'
endif
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Git enhancements
Plug 'tpope/vim-fugitive'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
Plug 'plasticboy/vim-markdown'
Plug 'sheerun/vim-polyglot'

call plug#end()

"}}}

" Settings {{{

let mapleader="\<Space>"

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
set noshowmode
set inccommand=nosplit
set noswapfile
set nobackup
set nowritebackup
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set diffopt+=iwhite
set diffopt+=vertical
set shortmess+=c      " don't give ins-completion-menu messages
set foldmethod=indent
set foldlevelstart=99 " start file with all folds opened
set cursorline

colorscheme gruvbox

"}}}

" Mappings {{{

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap Y y$
nnoremap Q @q
vnoremap Q :norm @q<CR>
nnoremap <Space> <Nop>
nnoremap <silent><leader><Space> zz:nohlsearch<CR>
nnoremap <leader>w :w!<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
nnoremap <silent><leader>q :Sayonara<CR>
nnoremap <silent><leader>Q :Sayonara!<CR>
nnoremap <leader>N :enew<CR>
nnoremap <leader><Tab> <C-^>
nnoremap <leader>op :e ~/dotfiles/.vimrc<CR>
nnoremap <leader>oi :IndentLinesToggle<CR>
nnoremap <leader>ou :UndotreeToggle<CR>
nnoremap <leader>oy :let @+=expand("%:p")<CR> :echo expand("%:p")<CR>
nnoremap <leader>od :windo diffthis<CR>
nnoremap <leader>oD :windo diffoff<CR>

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-k> <C-o>D

cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>


" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap W!! w !sudo tee > /dev/null %

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent><leader>s :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent><leader>s "sy:let @/=@s<CR>cgn

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <leader>R :%s///g<Left><Left>
xnoremap <leader>R :s///g<Left><Left>

"}}}

" Autocommands {{{

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

" Resize panes when window/terminal gets resize
autocmd! VimResized * wincmd =

" prevent unintended write
autocmd BufReadPost fugitive:///*//0/* setlocal nomodifiable readonly

" refresh changed content of file
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
            \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" only show cursorline in active window
augroup cusorlineToggle
    autocmd!
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
augroup END

" toggle relativenumber when lost focus
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * if &buftype != 'terminal' && &filetype != 'nerdtree' && &filetype != 'help' | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

"}}}

" {{{ File Type settings

autocmd BufNewFile,BufRead Podfile,podlocal,*.podspec,Fastfile setfiletype ruby

" }}}

" FZF {{{

nnoremap <silent><leader>f :Files<CR>
nnoremap <silent><leader>F :GFiles?<CR>
nnoremap <silent><leader>b :Buffers<CR>
nnoremap <silent><leader>h :History<CR>
nnoremap <silent><leader>L :BLines<CR>
nnoremap <silent><leader>l :Lines<CR>
nnoremap <silent><leader>' :Marks<CR>
nnoremap <silent><leader>; :Commands<CR>
nnoremap <silent><leader>: :History:<CR>
nnoremap <silent><leader>S :Filetypes<CR>
nnoremap <silent><leader>H :Helptags<CR>
nnoremap <silent><leader>M :Maps<CR>
nnoremap <silent><leader>/ :Rg<CR>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler nonumber norelativenumber |
            \ autocmd BufLeave <buffer> set laststatus=2 ruler
autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
autocmd FileType fzf tunmap <buffer> <Esc>

command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

"}}}

" Terminal {{{

let g:neoterm_autoscroll = 1
let g:neoterm_autoinsert = 1
let g:neoterm_default_mod = 'belowright'
nnoremap <leader>t :Ttoggle<CR>
nnoremap <leader>T :vert Ttoggle<CR>

"}}}

" NerdTree {{{

function! s:nerdtreeToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

" disable netrw
let loaded_netrwPlugin = 1
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']
nnoremap <silent><leader>n  :call <SID>nerdtreeToggle()<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"}}}

" Fugitive {{{

nnoremap <silent><leader>gg :Gstatus<CR>
nnoremap <silent><leader>gd :Gdiffsplit<CR>
nnoremap <silent><leader>gc :Gcommit -q<CR>
nnoremap <silent><leader>gp :Gpush<CR>
nnoremap <silent><leader>gf :Gfetch<CR>
nnoremap <silent><leader>gl :Glog<CR>
nnoremap <silent><leader>gb :Gblame<CR>
vnoremap <silent><leader>gb :Gblame<CR>
" via FZF
nnoremap <silent><leader>gh :Commits<CR>
nnoremap <silent><leader>gH :BCommits<CR>

"}}}

" lightline {{{

let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \   'active': {
            \     'left': [['mode', 'paste'], ['filename', 'readonly', 'modified']],
            \     'right': [['lineinfo'], ['percent'], ['filetype']]
            \   },
            \ }

"}}}

" delimitMate {{{

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

"}}}

" coc.vim {{{

" You will have bad experience for diagnostic messages when it's default 4000.
" set updatetime=300

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
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
nmap <silent> gD <Plug>(coc-references)

command! -nargs=0 Format :call CocAction('format')

"}}}

" buftabline {{{

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

"}}}

" tabular {{{

nnoremap <Leader>a: :Tabularize /:\zs<CR>
vnoremap <Leader>a: :Tabularize /:\zs<CR>
nnoremap <Leader>a, :Tabularize /,\zs<CR>
vnoremap <Leader>a, :Tabularize /,\zs<CR>

"}}}

" quickrun {{{

let g:quickrun_config = {
            \ '_': {
            \          'runner': 'shell'
            \      }
            \ }

"}}}

" highlightedyank {{{

let g:highlightedyank_highlight_duration = 100

"}}}

" autoformat {{{

nnoremap <leader>= :Autoformat<CR>
vnoremap <leader>= :Autoformat<CR>

"}}}
