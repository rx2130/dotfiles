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
let g:delimitMate_excluded_ft = "TelescopePrompt"

" GUI enhancements
Plug 'lifepillar/vim-gruvbox8'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files{find_command={'fd', '--type', 'f', '--hidden', '--follow', '--exclude', '.git'},cwd=telescope_search_dirs()}<cr>
nnoremap <leader>F <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>G <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>l <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader>L <cmd>lua require('telescope.builtin').builtin()<cr>
nnoremap <leader>' <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>; <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>: <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>S <cmd>lua require('telescope.builtin').filetypes()<cr>
nnoremap <leader>H <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>m <cmd>lua require('telescope.builtin').man_pages()<cr>
nnoremap <leader>M <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <leader>/ <cmd>lua require('telescope.builtin').live_grep({cwd=telescope_search_dirs()})<cr>
xnoremap <leader>/ "vy<cmd>lua require('telescope.builtin').grep_string({search=vim.fn.getreg('v'),cwd=telescope_search_dirs()})<cr>
nnoremap <leader>? <cmd>lua require('telescope.builtin').grep_string({cwd=telescope_search_dirs()})<cr>
xnoremap <leader>? "vy<cmd>lua require('telescope.builtin').grep_string({search=vim.fn.getreg('v'),cwd=telescope_search_dirs()})<cr>
nnoremap <leader>gh <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>gH <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_branches()<cr>

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1
" let g:rooter_change_directory_for_non_project_files = 'current'

" Git enhancements
Plug 'tpope/vim-fugitive'
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gf :Git fetch<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gb :Git blame<CR>
vnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gB :GBrowse<CR>
vnoremap <leader>gB :GBrowse<CR>

Plug 'tpope/vim-rhubarb'
Plug 'ssh://git.amazon.com:2222/pkg/Vim-code-browse'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
nnoremap <leader>gv :GV --all<CR>
nnoremap <leader>gV :GV<CR>

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
Plug 'hrsh7th/nvim-compe'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>ds :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>di :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>do :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

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
set mouse=a
set undofile
set inccommand=nosplit
set noswapfile
set lazyredraw
set scrolloff=1
set sidescrolloff=5
set cursorline
set nowrap
set signcolumn=number
set statusline=%<%f\ %m%r%=%-14.(%l,%v%)\ %Y
set diffopt=internal,filler,closeoff,hiddenoff,algorithm:histogram,indent-heuristic
set termguicolors
set smartindent " smart autoindenting when starting a new line
set shortmess+=I
set ttimeoutlen=0 " lower the delay of escaping out of other modes
set makeprg=brazil-build

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

colorscheme gruvbox8
let g:vimsyn_embed = 'l' " get Lua syntax highlighting inside .vim files
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
nnoremap <leader>, :e ~/dotfiles/vimrc<cr>
nnoremap <Tab> za
nnoremap <C-n>i <C-i>

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

    " termianl mode Esc map
    autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>

    " open help vertically
    autocmd BufEnter * if &filetype ==# 'help' | wincmd L | endif
    autocmd BufEnter * if &filetype ==# 'man' | wincmd L | endif

    " highlight yank
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=100}

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
    autocmd FileType java setlocal makeprg=brazil-build\ -emacs
    autocmd FileType java setlocal errorformat=%f:%l:\ %trror:\ %m,
                    \%-GReplacing%.%#,
                    \%-GBUILD\ FAILED%.%#,
                    \%-GTotal\ time:%.%#,
                    \%-GRunning%.%#,
                    \%-GRemoving%.%#,
                    \%-GUsing%.%#,
                    \%-GTrying%.%#,
                    \%-GDefining%.%#,
                    \%-GANT_%.%#,
                    \%-G%.%#HappierTrails%.%#,
                    \%-G%[\ 0-9]%.%#\ errors
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
        [">p"] = "@parameter.inner",
      },
      swap_previous = {
        ["<p"] = "@parameter.inner",
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
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
"}}}

" LSP {{{
lua << EOF
local virtual_text_show = true
function virtual_text_toggle()
    virtual_text_show = not virtual_text_show
    vim.lsp.diagnostic.display(vim.lsp.diagnostic.get(0, 1), 0, 1, {virtual_text = virtual_text_show, underline = virtual_text_show, signs = false})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = true,
        signs = false,
        update_in_insert = false,
    }
)

local on_attach = function(client)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(0, ...) end
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('i', '<c-l>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_set_keymap('n', 'gS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  buf_set_keymap('n', 'cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('v', '<leader>=', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>C', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'yot', '<cmd>lua virtual_text_toggle()<CR>', opts)
end

local nvim_lsp = require('lspconfig')
local servers = { "jsonls", "html", "cssls", "pyls", "gopls", "tsserver", "yamlls", "texlab" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

nvim_lsp.sumneko_lua.setup {
  cmd = {'lua-lsp.sh'};
  on_attach = on_attach,
  settings = {
      Lua = {
          runtime = {
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
          },
          diagnostics = {
              globals = {'vim'},
          },
          workspace = {
              library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
          },
      },
  },
}

local jdtls_on_attach = function(client)
    on_attach(client)
    require('jdtls').setup_dap()
    require('jdtls.setup').add_commands()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>a', "<cmd>lua require'jdtls'.code_action()<CR>", { noremap=true, silent=true })
end

jdtls_setup = function()
    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    if bufname:find("fugitive://") then return end
    if bufname:find("[java] ") then return end

    local root_markers = {'packageInfo'}
    local root_dir = require('jdtls.setup').find_root(root_markers)
    local home = os.getenv('HOME')
    local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ':p:h:t')

    local ws_folders_lsp = {}
    local ws_folders_jdtls = {}
    if root_dir then
        local file = io.open(root_dir .. "/.bemol/ws_root_folders", "r");
        if file then
            for line in file:lines() do
                table.insert(ws_folders_lsp, line);
                table.insert(ws_folders_jdtls, string.format("file://%s", line))
            end
            file:close()
        end
    end

    local jar_patterns = {
        '/Developer/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
        '/Developer/vscode-java-decompiler/server/*.jar',
        '/Developer/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar',
        '/Developer/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar',
        '/Developer/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar',
    }
    local bundles = {}
    for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
            if bundle ~= "" then
                table.insert(bundles, bundle)
            end
        end
    end

    local config = {
        on_attach = jdtls_on_attach,
        cmd = {'java-lsp.sh', eclipse_workspace},
        root_dir = root_dir,
        init_options = {
            bundles = bundles,
            workspaceFolders = ws_folders_jdtls,
        },
        settings = {
            java = {
                signatureHelp = { enabled = true };
                contentProvider = { preferred = 'fernflower' };
            }
        },
    }

    require('dap').configurations.java = {
      {
        type = 'java';
        request = 'attach';
        name = "Debug (Attach) - Remote";
        hostName = "127.0.0.1";
        port = 5005;
        projectName = "CBDSHeliosService";
      },
    }

    require('jdtls').start_or_attach(config)

    for _,line in ipairs(ws_folders_lsp) do
        vim.lsp.buf.add_workspace_folder(line)
    end
end
EOF

augroup lsp
    autocmd!
    autocmd FileType java luado jdtls_setup()
    autocmd FileType python lua require('dap-python').setup('/home/linuxbrew/.linuxbrew/bin/python3')
augroup end

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
"}}}

" telescope {{{
lua <<EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  }
}
require('telescope').load_extension('fzy_native')

telescope_search_dirs = function()
    local find_root = require'jdtls.setup'.find_root
    local bufname = vim.fn.expand('%:t:r')
    local root_dir = find_root({'packageInfo'}, bufname)
    if root_dir then
        return root_dir .. "/src/"
    end
end
EOF
"}}}
