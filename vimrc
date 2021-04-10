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
Plug 'justinmk/vim-dirvish'
Plug 'tyru/open-browser.vim'
let g:loaded_netrwPlugin = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

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
            \     'gitbranch': 'LightlineGitHead',
            \     'filename': 'LightlineFilename',
            \   }
            \ }

function! LightlineFilename()
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
        return path[len(root)+1:][40-winwidth(0):]
    endif
    return expand('%')[40-winwidth(0):]
endfunction

function! LightlineGitHead()
    let status = FugitiveStatusline()
    return status[5:len(status)-3]
endfunction

Plug 'junegunn/goyo.vim'
nnoremap <Leader>G :Goyo<CR>
Plug 'junegunn/limelight.vim'

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowcmd
  set scrolloff=999
  " Limelight
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showcmd
  set scrolloff=5
  " Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

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
nnoremap <leader>/ :Rg <CR>
xnoremap <leader>/ y:Rg <C-R>"<CR>
nnoremap <leader>? :Rg <C-R><C-W><CR>
xnoremap <leader>? y:Rg <C-R>"<CR>
nnoremap <leader>gh :Commits<CR>
nnoremap <leader>gH :BCommits<CR>
nnoremap <leader>, :Files ~/dotfiles<CR>v
nnoremap <expr> <C-p> ':Files<CR>'.expand('%:t:r')

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1
" let g:rooter_change_directory_for_non_project_files = 'current'

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

Plug 'tpope/vim-rhubarb'
Plug 'ssh://git.amazon.com:2222/pkg/Vim-code-browse'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
nnoremap <leader>gv :GV --all<CR>
nnoremap <leader>gV :GV<CR>

Plug 'stsewd/fzf-checkout.vim'
nnoremap <leader>gc :GBranches<CR>

" Semantic language support
Plug 'ssh://git.amazon.com:2222/pkg/VimIon.git'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1

Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
nmap <leader>p <Plug>MarkdownPreviewToggle
let g:mkdp_auto_close = 0

Plug 'fatih/vim-go'
Plug 'mfussenegger/nvim-jdtls'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'neovim/nvim-lsp'
Plug 'ojroques/nvim-lspfuzzy'
Plug 'hrsh7th/nvim-compe'

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
set autowrite

" https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set diffopt+=iwhite

let g:vimsyn_embed = 'l' " get Lua syntax highlighting inside .vim files

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
nnoremap <leader>w :w<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
nnoremap <leader><Tab> <C-^>
nnoremap <leader>c :cclose<bar>lclose<cr>
nnoremap <leader>t :vsplit \| terminal<cr>
nnoremap <leader>T :split \| terminal<cr>
nnoremap <leader>y :let @*=expand('%:t:r')<CR> :echo expand('%:t:r')<CR>
nnoremap <leader>Y :let @*=expand('%:p')<CR> :echo expand('%:p')<CR>
" nnoremap <leader>gf :diffget //2<CR>
" nnoremap <leader>gj :diffget //3<CR>

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
cnoremap <C-k> <C-\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<CR>

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
    autocmd FileType fzf tunmap <buffer> <Esc>

    " open help vertically
    autocmd BufEnter * if &filetype ==# 'help' | wincmd L | endif

    " highlight yank
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=100}

    " File Type settings
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " disable automatic comment insertion

    autocmd FileType gitcommit setlocal spell " spell check for git commits
    autocmd BufNewFile,BufRead *.ftl setfiletype ftl
    autocmd BufNewFile,BufRead .gitignore setfiletype gitconfig

    autocmd FileType git setlocal fdm=syntax
    autocmd Filetype gitconfig setlocal commentstring=#\ %s
    autocmd FileType ftl setlocal commentstring=<#--\ %s\ -->
    autocmd FileType ion setlocal commentstring=//\ %s

    autocmd FileType fugitive nmap <buffer> <TAB> =

    " nnoremap <leader>R :.w !bash<CR>
    autocmd FileType python nnoremap <buffer> <leader><CR> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType go     nnoremap <buffer> <leader><CR> :w<CR>:exec '!go run' shellescape(@%, 1)<CR>
    autocmd FileType java   nnoremap <buffer> <leader><CR> :w<CR>:!javac %:t<CR> :!java %:t:r<CR>
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

" Treesitter {{{
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}
EOF
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set foldlevelstart=99
"}}}

" LSP {{{
lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = true,
        signs = false,
        update_in_insert = false,
    }
)

on_attach = function(client)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(0, ...) end
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_set_keymap('n', 'gS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>C', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
end

local nvim_lsp = require('lspconfig')
local servers = { "jsonls", "html", "cssls", "pyls", "gopls", "tsserver", "yamlls", "texlab" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

require('lspfuzzy').setup {}
EOF

autocmd! FileType java lua require'jdtls'.start_or_attach({ on_attach = on_attach, cmd = {'java-lsp.sh'} })

function! s:OpenDiagnostics()
    lua vim.lsp.diagnostic.set_loclist { open_loclist = false, severity = "Error" }
    lwindow
endfunction

" display errors and warnings on save
autocmd! BufWritePost * call <SID>OpenDiagnostics()
"}}}

" completion {{{
lua <<EOF
require'compe'.setup {
  enabled = true;
  preselect = 'always';
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}
EOF

set completeopt=menuone,noselect
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ compe#complete()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"}}}
