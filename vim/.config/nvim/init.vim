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

" Plug 'justinmk/vim-gtfo'
Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-sleuth'
Plug 'kyazdani42/nvim-tree.lua'
nnoremap <Leader>n :NvimTreeFindFileToggle<CR>
nnoremap <Leader>N :NvimTreeFindFile<CR>

Plug 'tyru/open-browser.vim'
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'AndrewRadev/linediff.vim'

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
let g:delimitMate_excluded_ft = "DAP-REPL"

Plug 'tommcdo/vim-exchange'

" GUI enhancements
Plug 'sainnhe/gruvbox-material'
let g:gruvbox_material_better_performance = 1

" Fuzzy finder
Plug 'ibhagwan/fzf-lua'
nnoremap <leader>f <cmd>lua require('fzf-lua').files{cwd=fzf_cwd()}<cr>
nnoremap <expr> <C-p> ":lua require('fzf-lua').files()<cr>".expand('%:t:r')
nnoremap <leader>op <cmd>lua require('fzf-lua').files{cwd='~/.vim/plugged/'}<cr>
nnoremap <leader>od <cmd>lua require('fzf-lua').files{cwd='~/dotfiles/'}<cr>
nnoremap <leader>F <cmd>lua require('fzf-lua').git_status()<cr>
nnoremap <leader>b <cmd>lua require('fzf-lua').buffers()<cr>
nnoremap <leader>h <cmd>lua require('fzf-lua').oldfiles()<cr>
nnoremap <leader>l <cmd>lua require('fzf-lua').blines()<cr>
nnoremap <leader>L <cmd>lua require('fzf-lua').builtin()<cr>
nnoremap <leader>' <cmd>lua require('fzf-lua').marks()<cr>
nnoremap <leader>; <cmd>lua require('fzf-lua').commands()<cr>
nnoremap <leader>: <cmd>lua require('fzf-lua').command_history()<cr>
nnoremap <leader>S <cmd>lua require('fzf-lua').filetypes()<cr>
nnoremap <leader>H <cmd>lua require('fzf-lua').help_tags()<cr>
nnoremap <leader>m <cmd>lua require('fzf-lua').man_pages()<cr>
nnoremap <leader>M <cmd>lua require('fzf-lua').keymaps()<cr>
nnoremap <leader>/ <cmd>lua require('fzf-lua').live_grep({cwd=fzf_cwd()})<cr>
xnoremap <leader>/ <cmd>lua require('fzf-lua').grep_visual({cwd=fzf_cwd()})<cr>
nnoremap <leader>? <cmd>lua require('fzf-lua').live_grep()<cr>
xnoremap <leader>? <cmd>lua require('fzf-lua').grep_visual()<cr>
nnoremap <leader>gh <cmd>lua require('fzf-lua').git_commits()<cr>
nnoremap <leader>gH <cmd>lua require('fzf-lua').git_bcommits()<cr>
nnoremap <leader>gc <cmd>lua require('fzf-lua').git_branches()<cr>

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1
" let g:rooter_change_directory_for_non_project_files = 'current'

" Git enhancements
Plug 'tpope/vim-fugitive'
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

Plug 'tpope/vim-rhubarb'
Plug 'ssh://git.amazon.com:2222/pkg/Vim-code-browse'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
nnoremap <leader>gv :GV --all<CR>
nnoremap <leader>gV :GV<CR>

" Semantic language support
Plug 'ssh://git.amazon.com:2222/pkg/VimIon.git'
Plug 'ellisonleao/glow.nvim'
nnoremap <leader>p :Glow<CR>

" Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" nmap <leader>p <Plug>MarkdownPreviewToggle
" let g:mkdp_auto_close = 0

Plug 'neovim/nvim-lsp'
Plug 'mfussenegger/nvim-jdtls'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dd :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>di :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>do :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle({height=15})<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>dC :lua require'dap'.run_to_cursor()<CR>
nnoremap <silent> <leader>df :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)<CR>
nnoremap <silent> <leader>ds :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)<CR>
nnoremap <silent> <leader>K  :lua require('dap.ui.widgets').hover()<CR>
vnoremap <silent> <leader>K  :lua require('dap.ui.widgets').hover(require("dap.utils").get_visual_selection_text)<CR>
nnoremap <silent> <leader>du :lua local widgets = require('dap.ui.widgets'); widgets.sidebar(widgets.scopes).open(); widgets.sidebar(widgets.frames).open()<CR>
" command! -nargs=0 DapBreakpoints :lua require('dap').list_breakpoints()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

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
set statusline=%<%f\ %m%r%=%-14.(%l,%v%)\ %Y
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
set matchpairs+=<:> " pairs for % command
set completeopt=menu,menuone,noselect
set updatetime=250
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set foldlevelstart=99

colorscheme gruvbox-material
"}}}

" Mappings {{{

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap Q @q
vnoremap Q :norm @q<CR>
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
nnoremap <leader>t :vsplit \| terminal<cr>
nnoremap <leader>T :split \| terminal<cr>
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
    autocmd BufEnter * if &filetype ==# 'help' | wincmd L | endif
    autocmd BufEnter * if &filetype ==# 'man' | wincmd L | endif

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

    " makeprg
    autocmd FileType go setlocal errorformat=%f:%l.%c-%[%^:]%#:\ %m,%f:%l:%c:\ %m

    " formatprg
    autocmd FileType json setlocal formatprg=python\ -m\ json.tool
    autocmd FileType java setlocal formatprg=java\ -jar\ ~/Developer/google-java-format-1.6-all-deps.jar\ -a\ -
    autocmd FileType lua  setlocal formatprg=stylua\ -
    autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript formatexpr=
    autocmd FileType markdown setlocal formatprg=prettier\ --parser\ markdown
    autocmd FileType python setlocal formatprg=black\ --quiet\ -

    " LSP
    autocmd FileType java lua require('me.lsp').start_jdt()

    " display errors and warnings on save
    autocmd BufWritePost * lua vim.diagnostic.setloclist{open_loclist = false, severity = "Error"}; vim.api.nvim_command('lwindow')

    " highlight current var under cursor
    autocmd CursorHold  * lua vim.lsp.buf.document_highlight()
    autocmd CursorHoldI * lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved * lua vim.lsp.buf.clear_references()
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
