" vim: set fdm=marker fmr={{{,}}} fdl=99 :

let mapleader = ' '

" load plugins {{{

call plug#begin('~/.vim/plugged')

" Vim enhancements
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
nnoremap <silent><leader>q :Sayonara<CR>
nnoremap <silent>q<leader> :Sayonara<CR>
nnoremap <silent><leader>Q :Sayonara!<CR>

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
nnoremap <leader>ou :UndotreeToggle<CR>

Plug 'thalesmello/tabfold'
Plug 'thinca/vim-quickrun'
Plug 'lambdalisue/vim-quickrun-neovim-job'
let g:quickrun_config = {'_': {}}
let g:quickrun_config._.runner = 'neovim_job'

Plug 'tpope/vim-sleuth'
Plug 'chiel92/vim-autoformat'
nnoremap <leader>= :Autoformat<CR>
vnoremap <leader>= :Autoformat<CR>

Plug 'tpope/vim-vinegar'
let g:netrw_liststyle = 3

Plug 'tpope/vim-dispatch'
let g:dispatch_no_tmux_make = 1

" Edit enhancements
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'nelstrom/vim-visual-star-search'
Plug 'raimondi/delimitmate'
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

Plug 'vim-scripts/ReplaceWithRegister'

" GUI enhancements
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \   'active': {
            \     'left': [['mode', 'paste'], ['gitbranch'], ['filename', 'readonly', 'modified']],
            \     'right': [['lineinfo'], ['percent'], ['filetype']]
            \   },
            \   'component_function': {
            \     'gitbranch': 'FugitiveHead',
            \     'filename': 'LightlineFilename',
            \   },
            \   'component': {
            \     'lineinfo': '%3l:%-2v%<',
            \   },
            \ }

function! LightlineFilename()
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
        return path[len(root)+1:]
    endif
    return expand('%')
endfunction

Plug 'yggdroot/indentLine', { 'on': 'IndentLinesToggle' }
nnoremap <leader>oi :IndentLinesToggle<CR>
" lazy load indentLine
autocmd! User indentLine doautocmd indentLine Syntax

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 100

Plug 'haya14busa/is.vim'

" Fuzzy finder
if has("macunix")
    Plug '/usr/local/opt/fzf'
else
    Plug '/usr/share/doc/fzf/examples'
endif
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit',
            \ }

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
nnoremap <silent><leader>? :History/<CR>
nnoremap <silent><leader>gh :Commits<CR>
nnoremap <silent><leader>gH :BCommits<CR>

autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noruler |
            \ autocmd BufLeave <buffer> set laststatus=2 ruler
autocmd FileType fzf tunmap <buffer> <Esc>

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1
let g:rooter_change_directory_for_non_project_files = 'current'

" Git enhancements
Plug 'tpope/vim-fugitive'
nnoremap <silent><leader>gg :Gstatus<CR>
nnoremap <silent><leader>gd :Gdiffsplit<CR>
nnoremap <silent><leader>gc :Gcommit -q<CR>
nnoremap <silent><leader>gp :Gpush<CR>
nnoremap <silent><leader>gf :Gfetch<CR>
nnoremap <silent><leader>gl :Gpull<CR>
nnoremap <silent><leader>gb :Gblame<CR>
vnoremap <silent><leader>gb :Gblame<CR>
nnoremap <silent><leader>gB :Gbrowse<CR>
vnoremap <silent><leader>gB :Gbrowse<CR>

" prevent unintended write
autocmd BufReadPost fugitive:///*//0/* setlocal nomodifiable readonly

Plug 'shumphrey/fugitive-gitlab.vim'
let g:fugitive_gitlab_domains = ['http://gitlab.alibaba-inc.com']

Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
nnoremap <silent><leader>gv :GV --all<CR>


" Syntactic language support
Plug 'sheerun/vim-polyglot'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" use <C-Space>for trigger completion
inoremap <expr> <C-Space> coc#refresh()

" Use <cr> to confirm completion
imap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<Plug>delimitMateCR"

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
nmap <silent> g? <Plug>(coc-references)

command! -nargs=0 Format :call CocAction('format')

call plug#end()

"}}}

" Settings {{{

set clipboard=unnamed
set splitright
set splitbelow
set ignorecase
set smartcase
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
set hidden
set mouse=nvi
set undofile
set autowrite
set autowriteall
set inccommand=nosplit
set noswapfile
set nobackup
set nowritebackup
set shortmess+=c      " don't give ins-completion-menu messages
set lazyredraw
set noshowmode

colorscheme gruvbox
if has('termguicolors') && $COLORTERM =~# 'truecolor\|24bit'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

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
nnoremap <silent><leader>N :vnew<CR>
nnoremap <leader><Tab> <C-^>
nnoremap <leader>o <Nop>
nnoremap <leader>op :e ~/dotfiles/.vimrc<CR>
nnoremap <leader>oy :let @+=expand("%:p:~")<CR> :echo expand("%:p:~")<CR>
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
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-d> <Del>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap W!! w !sudo tee > /dev/null %

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent><leader>s :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent><leader>s "sy:let @/=@s<CR>cgn

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <leader>R :%s///g<Left><Left>
xnoremap <leader>R :s///g<Left><Left>

" Zoom
function! s:zoom()
    if winnr('$') > 1
        tab split
    elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                \ 'index(v:val, '.bufnr('').') >= 0')) > 1
        tabclose
    endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

"}}}

" Autocommands {{{

augroup vimrc
    autocmd!
    " Set vim to save the file on focus out
    autocmd FocusLost * silent! :wa

    " Automatically source .vimrc on save
    autocmd BufWritePost .vimrc nested source $MYVIMRC

    " Remember last cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    " open help vertically
    autocmd FileType help wincmd L

    " spell check for git commits
    autocmd FileType gitcommit setlocal spell

    " Resize panes when window/terminal gets resize
    autocmd VimResized * wincmd =

    " refresh changed content of file
    autocmd CursorHold * if getcmdwintype() == '' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg | echo "Warning: File changed on disk. Buffer reloaded." | echohl None

    " termianl mode Esc map
    autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>

    " File Type settings
    autocmd BufNewFile,BufRead Podfile,podlocal,*.podspec,Fastfile setfiletype ruby
augroup END

"}}}

" <Leader>G/! | Google it / Feeling lucky {{{
function! s:goog(pat, lucky)
    let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
    let q = substitute(q, '[[:punct:] ]',
                \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
    call system(printf('open "https://www.google.com/search?%sq=%s"',
                \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>G :call <SID>goog(expand("<cWORD>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
xnoremap <leader>G "gy:call <SID>goog(@g, 0)<cr>gv
xnoremap <leader>! "gy:call <SID>goog(@g, 1)<cr>gv
"}}}
