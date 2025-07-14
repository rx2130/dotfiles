" vim: set fdm=marker fmr={{{,}}} fdl=99 :

let mapleader = ' '

" load plugins {{{

" Vim enhancements
nnoremap <silent><leader>q :Sayonara<CR>
nnoremap <silent><leader>Q :Sayonara!<CR>

nnoremap <leader>u :UndotreeToggle<CR>

nnoremap <silent><Leader>n :NvimTreeFindFileToggle<CR>
nnoremap <silent><Leader>N :NvimTreeFindFile<CR>

" GUI enhancements
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_transparent_background = 1

" Git enhancements
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gp :Dispatch git push<CR>
nnoremap <leader>gP :Dispatch git push -f<CR>
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
"}}}

" Settings {{{

set nonumber
set showmode
set clipboard+=unnamedplus
set expandtab " tab byte (\x09) will be replaced with a number of space bytes (\x20)
set tabstop=4 " how long each <tab> will be
set shiftwidth=4 " indentation via =, > and <
set shiftround
set noswapfile
set lazyredraw
set scrolloff=1
set sidescrolloff=5
set signcolumn=number
set statusline=%!v:lua.require'me.statusline'.setup()
set diffopt+=hiddenoff,algorithm:histogram,indent-heuristic
set diffopt+=vertical " Always use vertical diffs
set shortmess+=I
set ttimeoutlen=0 " lower the delay of escaping out of other modes
if filereadable("./Config")
    set makeprg=brazil-build
end
set updatetime=250
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set foldtext=
set fillchars=fold:\ 
set laststatus=3
set jumpoptions=view
set mousescroll=ver:1,hor:0
set mousemodel=extend
set pumheight=20
set scrollback=100000
set nomodeline

colorscheme gruvbox-material
"}}}

" Mappings {{{

vnoremap . :norm .<CR>
nnoremap <silent><esc> :nohlsearch<cr>
nnoremap <Tab> za
nnoremap <C-n>i <C-i>
nnoremap <silent><C-w>] :vert winc ]<CR>
nnoremap <silent><C-w>f :vert winc f<CR>

nnoremap <Space> <Nop>
nnoremap <silent><leader><Space> zz:nohlsearch<CR>
vnoremap <silent><leader><Space> <esc>zz:nohlsearch<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
nnoremap <leader><Tab> <C-^>
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

    " Resize panes when window/terminal gets resize
    " autocmd VimResized * wincmd =

    " termianl mode Esc map
    autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
    autocmd FileType fzf tunmap <buffer> <Esc>

    " open help vertically
    " autocmd BufEnter * if &filetype ==# 'help' | wincmd L | endif
    " autocmd BufEnter * if &filetype ==# 'man' | wincmd L | endif

    " File Type settings
    autocmd FileType gitcommit setlocal spell " spell check for git commits
    autocmd FileType git setlocal foldmethod=syntax foldlevel=0

    " File Type mappings
    autocmd FileType fugitive nmap <buffer> <TAB> =

    " setfiletype
    autocmd BufNewFile,BufRead *.ftl setfiletype ftl
    autocmd BufNewFile,BufRead *.mustache setfiletype html
    autocmd BufNewFile,BufRead */git/config setfiletype gitconfig
    autocmd BufNewFile,BufRead Config setfiletype perl

    " commentstring
    autocmd FileType ftl setlocal commentstring=<#--\ %s\ -->
    autocmd FileType ion,c setlocal commentstring=//\ %s

    " run file
    autocmd FileType sh     nnoremap <buffer> <leader><CR> :w !sh<CR>
    autocmd FileType sh     vnoremap <buffer> <leader><CR> :w !sh<CR>
    autocmd FileType python nnoremap <buffer> <leader><CR> :!python3 "%"<CR>
    autocmd FileType go     nnoremap <buffer> <leader><CR> :!go run %<CR>
    autocmd FileType java   nnoremap <buffer> <leader><CR> :!javac %:t<CR> :!java %:t:r<CR>
    autocmd FileType scala  nnoremap <buffer> <leader><CR> :!scala %<CR>
    autocmd FileType lua    nnoremap <buffer> <leader><CR> :luafile %<CR>
    autocmd FileType javascript nnoremap <buffer> <leader><CR> :!node %<CR>
    autocmd FileType typescript nnoremap <buffer> <leader><CR> :!ts-node %<CR>

    " formatprg
    autocmd FileType typescript setlocal formatexpr=
    autocmd FileType markdown setlocal formatprg=prettier\ --parser\ markdown

    " display errors and warnings on save
    " autocmd BufWritePost * lua vim.diagnostic.setloclist{open_loclist = false, severity = "Error"}; vim.api.nvim_command('lwindow')

    " disable new line auto-commenting. other plugins modify it thus autocmd 
    autocmd BufEnter * setlocal formatoptions-=o

    " only show cursor line in active window
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
