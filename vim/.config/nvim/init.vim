" vim: set fdm=marker fmr={{{,}}} fdl=99 :

let mapleader = ' '

" load plugins {{{

" Vim enhancements
nnoremap <silent><leader>q :Sayonara<CR>
nnoremap <silent><leader>Q :Sayonara!<CR>

nnoremap <leader>u :UndotreeToggle<CR>

nnoremap <silent><Leader>n :NvimTreeFindFileToggle<CR>
nnoremap <silent><Leader>N :NvimTreeFindFile<CR>

" Edit enhancements
nmap <Leader>r  <Plug>ReplaceWithRegisterOperator
nmap <Leader>rr <Plug>ReplaceWithRegisterLine
xmap <Leader>r  <Plug>ReplaceWithRegisterVisual

" GUI enhancements
let g:gruvbox_material_better_performance = 1

let g:rooter_silent_chdir = 1
" let g:rooter_change_directory_for_non_project_files = 'current'

" Git enhancements
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gp :Dispatch git push<CR>
nnoremap <leader>gf :Dispatch git fetch<CR>
nnoremap <leader>gl :Dispatch git pull<CR>
nnoremap <leader>gb :Git blame<CR>
vnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gx :GBrowse<CR>
vnoremap <leader>gx :GBrowse<CR>
nnoremap <leader>gy :GBrowse!<CR>
vnoremap <leader>gy :GBrowse!<CR>

nnoremap <leader>gv :GV --all<CR>
nnoremap <leader>gV :GV<CR>

nnoremap <leader>p :Glow<CR>

"}}}

" Settings {{{

set clipboard=unnamed
set splitright
set splitbelow
set ignorecase " Search case insensitive...
set smartcase " ... but not it begins with upper case
set expandtab " tab byte (\x09) will be replaced with a number of space bytes (\x20)
set tabstop=4 " how long each <tab> will be
set shiftwidth=4 " indentation via =, > and <
set shiftround
set mouse=a
set undofile
set noswapfile
set lazyredraw
set scrolloff=1
set sidescrolloff=5
set cursorline
set nowrap
set signcolumn=number
set statusline=%!v:lua.require'me.statusline'.setup()
set diffopt=internal,filler,closeoff,hiddenoff,algorithm:histogram,indent-heuristic
set diffopt+=vertical " Always use vertical diffs
set termguicolors
set smartindent " smart autoindenting when starting a new line
set shortmess+=I
set ttimeoutlen=0 " lower the delay of escaping out of other modes
if filereadable("./Config")
    set makeprg=brazil-build
end
set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m,%f:%l:%m
" set matchpairs+=<:> " pairs for % command
set completeopt=menu,menuone,noselect
set updatetime=250
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set laststatus=3

colorscheme gruvbox-material
"}}}

" Mappings {{{

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
vnoremap . :norm .<CR>
nnoremap <silent><esc> :nohlsearch<cr>
nnoremap <Tab> za
nnoremap <C-n>i <C-i>
nnoremap <silent><C-w>] :vert winc ]<CR>

nnoremap <Space> <Nop>
nnoremap <silent><leader><Space> zz:nohlsearch<CR>
vnoremap <silent><leader><Space> <esc>zz:nohlsearch<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
nnoremap <leader><Tab> <C-^>
nnoremap <leader>c :cclose<bar>lclose<cr>
nnoremap <leader>y :let @*=expand('%:t:r')<CR> :echo expand('%:t:r')<CR>
nnoremap <leader>Y :let @*=expand('%:p')<CR> :echo expand('%:p')<CR>
nnoremap <leader>, :e $MYVIMRC<cr>
nnoremap <leader>* *N

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-k> <C-o>D
imap <C-h> <BS>

cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-d> <Del>
cnoremap <C-k> <C-\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<CR>

xnoremap <expr> I (mode()=~#'[vV]'?'<C-v>^o^I':'I')
xnoremap <expr> A (mode()=~#'[vV]'?'<C-v>0o$A':'A')

" Search only between visual range
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

nmap <silent><leader>s *Ncgn
xmap <silent><leader>s *Ncgn

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <leader>R :%s///g<Left><Left>
xnoremap <leader>R :s///g<Left><Left>

"}}}

" Autocommands {{{

augroup vimrc
    autocmd!

    " Automatically source vimrc on save
    autocmd BufWritePost vimrc,$MYVIMRC nested source $MYVIMRC

    " Remember last cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    " Resize panes when window/terminal gets resize
    autocmd VimResized * wincmd =

    " termianl mode Esc map
    autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
    autocmd FileType fzf tunmap <buffer> <Esc>

    " open help vertically
    " autocmd BufEnter * if &filetype ==# 'help' | wincmd L | endif
    " autocmd BufEnter * if &filetype ==# 'man' | wincmd L | endif

    " highlight yank
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()

    " File Type settings
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " disable automatic comment insertion
    autocmd FileType gitcommit setlocal spell " spell check for git commits
    autocmd FileType git setlocal foldmethod=syntax foldlevel=0

    " File Type mappings
    autocmd FileType fugitive nmap <buffer> <TAB> =

    " setfiletype
    autocmd BufNewFile,BufRead *.ftl setfiletype ftl
    autocmd BufNewFile,BufRead *.mustache setfiletype html
    autocmd BufNewFile,BufRead .gitignore setfiletype gitconfig
    autocmd BufNewFile,BufRead Config setfiletype conf

    " commentstring
    autocmd FileType gitconfig setlocal commentstring=#\ %s
    autocmd FileType ftl setlocal commentstring=<#--\ %s\ -->
    autocmd FileType ion setlocal commentstring=//\ %s

    " run file
    autocmd FileType sh     nnoremap <buffer> <leader><CR> :w !sh<CR>
    autocmd FileType sh     vnoremap <buffer> <leader><CR> :w !sh<CR>
    autocmd FileType python nnoremap <buffer> <leader><CR> :exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType go     nnoremap <buffer> <leader><CR> :exec '!go run' shellescape(@%, 1)<CR>
    autocmd FileType java   nnoremap <buffer> <leader><CR> :!javac %:t<CR> :!java %:t:r<CR>
    autocmd FileType lua    nnoremap <buffer> <leader><CR> :luafile %<CR>
    autocmd FileType javascript nnoremap <buffer> <leader><CR> :!node %<CR>
    autocmd FileType typescript nnoremap <buffer> <leader><CR> :!ts-node %<CR>

    " makeprg
    autocmd FileType go setlocal errorformat=%f:%l.%c-%[%^:]%#:\ %m,%f:%l:%c:\ %m

    " formatprg
    autocmd FileType json setlocal formatprg=python3\ -m\ json.tool
    autocmd FileType java setlocal formatprg=java\ -jar\ ~/Developer/google-java-format-1.6-all-deps.jar\ -a\ -
    autocmd FileType lua  setlocal formatprg=stylua\ -
    autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript formatexpr=
    autocmd FileType javascript setlocal formatprg=prettier\ --parser\ typescript
    autocmd FileType html setlocal formatprg=prettier\ --parser\ html
    autocmd FileType markdown setlocal formatprg=prettier\ --parser\ markdown
    autocmd FileType python setlocal formatprg=black\ --quiet\ -

    " display errors and warnings on save
    autocmd BufWritePost * lua vim.diagnostic.setloclist{open_loclist = false, severity = "Error"}; vim.api.nvim_command('lwindow')
augroup END

" only show cursor line in active window
augroup cusorlineToggle
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END

"}}}

" handy tools {{{

" ----------------------------------------------------------------------------
" <Leader>z zoom
" ----------------------------------------------------------------------------
function! s:zoom()
    if winnr('$') > 1
        tab split
    elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                \ 'index(v:val, '.bufnr('').') >= 0')) > 1
        tabclose
    endif
endfunction

nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" ----------------------------------------------------------------------------
" ?ae | entire object
" ----------------------------------------------------------------------------
xnoremap <silent> ae gg0oG$
onoremap <silent> ae :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>
"}}}


lua require('me.lsp')
lua require('me.dap')
lua require('me.plugin_options')
