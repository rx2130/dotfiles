" vim: set fdm=marker fmr={{{,}}} fdl=99 :

let mapleader = ' '

" load plugins {{{

call plug#begin('~/.vim/plugged')

" Vim enhancements
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
nnoremap <silent><leader>q :Sayonara<CR>
nnoremap <silent><leader>Q :Sayonara!<CR>

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
nnoremap <leader>u :UndotreeToggle<CR>

Plug 'justinmk/vim-gtfo'
Plug 'thalesmello/tabfold'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
nmap <Leader>- <Plug>VinegarUp
nnoremap - -
let g:netrw_liststyle = 3

Plug 'tpope/vim-dispatch'
let g:dispatch_no_tmux_make = 1

" Edit enhancements
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'nelstrom/vim-visual-star-search'
Plug 'vim-scripts/ReplaceWithRegister'
nmap <Leader>r  <Plug>ReplaceWithRegisterOperator
nmap <Leader>rr <Plug>ReplaceWithRegisterLine
xmap <Leader>r  <Plug>ReplaceWithRegisterVisual

Plug 'raimondi/delimitmate'
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" GUI enhancements
Plug 'gruvbox-community/gruvbox'
let g:gruvbox_invert_selection='0'

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

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit',
            \ }

nnoremap <leader>f :Files<CR>
nnoremap <leader>F :GFiles?<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <leader>' :Marks<CR>
nnoremap <leader>; :Commands<CR>
nnoremap <leader>: :History:<CR>
nnoremap <leader>S :Filetypes<CR>
nnoremap <leader>H :Helptags<CR>
nnoremap <leader>M :Maps<CR>
nnoremap <leader>/ :Rg<CR>
nnoremap <leader>? :History/<CR>
nnoremap <leader>gh :Commits<CR>
nnoremap <leader>gH :BCommits<CR>
nnoremap <leader>, :Files ~/dotfiles<CR>v
nnoremap <expr> <C-p> ':Files<CR>'.expand('%:t:r')

autocmd! FileType fzf tunmap <buffer> <Esc>

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1
let g:rooter_change_directory_for_non_project_files = 'current'

" Git enhancements
Plug 'tpope/vim-fugitive'
nnoremap <leader>gg :Gstatus<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gf :Gfetch<CR>
nnoremap <leader>gl :Gpull<CR>
nnoremap <leader>gb :Gblame<CR>
vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gB :Gbrowse<CR>
vnoremap <leader>gB :Gbrowse<CR>

" prevent unintended write
autocmd! BufReadPost fugitive:///*//0/* setlocal nomodifiable readonly

Plug 'tpope/vim-rhubarb'
Plug 'ssh://git.amazon.com:2222/pkg/Vim-code-browse'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
nnoremap <leader>gv :GV --all<CR>
nnoremap <leader>gV :GV<CR>

Plug 'stsewd/fzf-checkout.vim'
nnoremap <leader>gc :GBranches <CR>

" Semantic language support
Plug 'ssh://git.amazon.com:2222/pkg/VimIon.git'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
nmap <leader>p <Plug>MarkdownPreviewToggle
let g:mkdp_auto_close = 1
let g:markdown_folding=1

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'

call plug#end()

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
set hidden
set mouse=nvi
set undofile
" set inccommand=nosplit
set noswapfile
set lazyredraw
set noshowmode
set scrolloff=1
set sidescrolloff=5
set cursorline
set nowrap
set signcolumn=number

" https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set diffopt+=iwhite

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
vnoremap . :norm .<CR>
nnoremap <silent><esc> :nohlsearch<cr>

nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
vnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

nnoremap <Space> <Nop>
nnoremap <silent><leader><Space> zz:nohlsearch<CR>
vnoremap <silent><leader><Space> <esc>zz:nohlsearch<CR>
nnoremap <leader>w :update<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
nnoremap <leader><Tab> <C-^>
nnoremap <leader>c :cclose<bar>lclose<cr>
nnoremap <leader>t :vsplit \| terminal<cr>
nnoremap <leader>T :split \| terminal<cr>
nnoremap <leader>y :let @*=expand('%:t:r')<CR>
nnoremap <leader>Y :let @*=expand('%:p')<CR>
nnoremap <leader>gf :diffget //2<CR>
nnoremap <leader>gj :diffget //3<CR>

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

xnoremap <expr> I (mode()=~#'[vV]'?'<C-v>^o^I':'I')
xnoremap <expr> A (mode()=~#'[vV]'?'<C-v>0o$A':'A')

nmap <silent><leader>s *''cgn
xmap <silent><leader>s *''cgn

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <leader>R :%s///g<Left><Left>
xnoremap <leader>R :s///g<Left><Left>

"}}}

" Autocommands {{{

augroup vimrc
    autocmd!

    " Set vim to save the file on focus out
    autocmd FocusLost * silent! :wa

    " Automatically source vimrc on save
    autocmd BufWritePost vimrc,$MYVIMRC nested source $MYVIMRC

    " Remember last cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    " Resize panes when window/terminal gets resize
    autocmd VimResized * wincmd =

    " refresh changed content of file
    autocmd FileChangedShellPost * echohl WarningMsg | echom "Warning: File changed on disk. Buffer reloaded." | echohl None

    " termianl mode Esc map
    autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>

    " open help vertically
    autocmd BufEnter * if &filetype ==# 'help' | wincmd L | endif

    " highlight yank
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=100}

    " File Type settings
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " disable automatic comment insertion
    autocmd FileType gitcommit setlocal spell " spell check for git commits
    autocmd BufNewFile,BufRead *.ftl setfiletype ftl
    autocmd FileType ftl setlocal commentstring=<#--\ %s\ -->

    " nnoremap <leader>R :.w !bash<CR>
    autocmd FileType python map <buffer> <leader><CR> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
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
" <Leader>G/! | Google it / Feeling lucky
" ----------------------------------------------------------------------------
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

" ----------------------------------------------------------------------------
" ?ae | entire object
" ----------------------------------------------------------------------------
xnoremap <silent> ae gg0oG$
onoremap <silent> ae :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>
"}}}

" Treesitter {{{
lua << EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    }
}
EOF
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set foldlevelstart=20
"}}}

" LSP {{{
lua << EOF
local custom_lsp_attach = function(client)
    vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true, silent = true})
    -- vim.api.nvim_buf_set_keymap(0, 'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true, silent = true})
end

require'lspconfig'.jsonls.setup{ on_attach = custom_lsp_attach }
require'lspconfig'.html.setup{ on_attach = custom_lsp_attach }
require'lspconfig'.cssls.setup{ on_attach = custom_lsp_attach }
require'lspconfig'.pyls.setup{ on_attach = custom_lsp_attach }
require'lspconfig'.gopls.setup{ on_attach = custom_lsp_attach }
require'lspconfig'.tsserver.setup{ on_attach = custom_lsp_attach }
require'lspconfig'.yamlls.setup{ on_attach = custom_lsp_attach }
require'lspconfig'.jdtls.setup{
    on_attach = on_attach,
    settings = {
        init_options = {
            jvm_args = {"-javaagent:/Users/xuerx/Developer/lombok.jar -Xbootclasspath/a:/Users/xuerx/Developer/lombok.jar"}
        }
    }
}
EOF
"}}}

" completion {{{
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'buffer']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]
let g:completion_matching_strategy_list = ['exact', 'fuzzy']
let g:completion_matching_ignore_case = 1

" Use <cr> to confirm completion
let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-n>\<CR>" :  "\<Plug>delimitMateCR"

" map <c-space> to manually trigger completion
imap <silent> <c-space> <Plug>(completion_trigger)

" Trigger completion with <Tab>
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
"}}}

" diagnostic {{{
" lua << EOF
" do
"   local method = "textDocument/publishDiagnostics"
"   local default_callback = vim.lsp.callbacks[method]
"   vim.lsp.callbacks[method] = function(err, method, result, client_id)
"     default_callback(err, method, result, client_id)
"     if result and result.diagnostics then
"       for _, v in ipairs(result.diagnostics) do
"         v.bufnr = client_id
"         v.lnum = v.range.start.line + 1
"         v.col = v.range.start.character + 1
"         v.text = v.message
"       end
"       vim.lsp.util.set_qflist(result.diagnostics)
"     end
"   end
" end
" EOF
"}}}
