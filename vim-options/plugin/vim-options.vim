" General Settings
filetype plugin on " Enable default plugins
set nocompatible " Disable vi-compatible
set wildmenu " Enable autocomple menu
set incsearch " Show search results as typing string
set hlsearch " Highlight matches to previos search string
set title


" move over split screen
set wmh=0
nnoremap <c-j> <C-W>j<C-W>_
nnoremap <c-k> <C-W>k<C-W>_

"substitute:
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

set nowrap " Turn off text wrapping long lines
set nosmartindent
set noautoindent

"set expandtab " In Insert mode: Use the appropriate number of spaces to insert <Tab>.
set tabstop=4 "Number of spaces that a <Tab> counts for
set shiftwidth=4 " Make shiftwidth value the same as tabstop
set cino+=(0

set number relativenumber " Use relative numbers in the side bar

set backspace=indent,eol,start
set ruler
set novisualbell
set noerrorbells
set lazyredraw

" Always show the status line
set laststatus=2

set history=1000 " Set number of ':' commands
set wildmode=list:full " wildmenu show list complete to first result
set splitright " New windows split to the right of current one
set splitbelow " New windows split below the current one
set completeopt-=preview " Hide the preview/scratch window
set path+=**/*

set wildignore=*/app/cache,*/vendor,*/env,*.pyc,*/venv,*/__pycache__,*/venv " Ignore folders
set sessionoptions+=globals " Append global variables to the default session options (Window Names)


" Custom status line
set statusline=
set statusline+=%1*\ %02c\                    " Color
set statusline+=%2*\ »                        " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
set statusline+=%3*\ %<%F\                    " File+path
set statusline+=%2*\«                         " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
set statusline+=%2*\ %=\ %l/%L\ (%02p%%)\     " Rownumber/total (%)

" Set spacing of filetypes
au FileType vim,ledger,yaml,html,htmldjango setlocal tabstop=2
au FileType sh,python setlocal tabstop=4
au FileType make setlocal tabstop=4 noexpandtab

" Setup colorscheme
syntax enable 
let g:solarized_termcolors=256
set mouse=a
set showmatch "highlight matching [{(
set background=light
colorscheme solarized

"powerline
"let g:powerline_pycmd = 'py3'
"let g:airline#extensions#whitespace#mixed_indent_algo = 2	

" Set vimdiff colors, make it easier to read
highlight DiffAdd    cterm=BOLD ctermfg=NONE ctermbg=22
highlight DiffDelete cterm=BOLD ctermfg=NONE ctermbg=52
highlight DiffChange cterm=BOLD ctermfg=NONE ctermbg=23
highlight DiffText   cterm=BOLD ctermfg=NONE ctermbg=23
" Disable Background Color for transparency
hi Normal guibg=NONE ctermbg=NONE

" Highlight lines at 80 mark/120 mark
highlight ColorColumn ctermbg=cyan
au BufEnter *.py let w:m1=matchadd('ColorColumn', '\%81v', 100)
au BufEnter *.py let w:m2=matchadd('Error', '\%121v', 100)
au BufLeave *.py call clearmatches()

" Neovim (Docker) vs Vim
if has('nvim')
  let $EditorDir='/root/.config/nvim/'
  let $SessionDir='.vimcache'
	silent! execute '!mkdir -p .vimcache/backup'
else
  let $EditorDir=$HOME.'/.vim/'
  let $SessionDir='.'
endif

" My Shorcuts
"let mapleader="\<Space>"

" type jj to get out of insert mode
inoremap jj <ESC>
" Ctags for python project
command! MakeTagsPython !ctags --languages=python --python-kinds=-i -R .
" Command for figuring out highlight group
map <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
" Turn off syntax highlighting
nnoremap <leader><leader> :noh<CR>
" New tab
nnoremap <C-w>t :tabnew<CR>
" Visually select pasted text
nnoremap gp `[v`]
" Vimdiff commands
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>dd :diffget<CR>
nnoremap <leader>df :diffput<CR>
nnoremap _ [c
nnoremap = ]c
" Visually select line without ending
nnoremap <leader>v ^v$h
" Some very useful shortcuts for editing Ledger entries
" Copy the last entry
nnoremap <leader>ll G{jV}y}p10l
" Copy the current entry to the bottom, copy date from last entry
nnoremap <leader>lb {jV}yGp10l{{jvEy}jvEpl
" Copy the current entry to the next position
nnoremap <leader>ln {jV}y}p10l
" Jump down from line to replace dollar ammount
nnoremap <leader>ld j^f$lC
" After searching pull entry to current position
nnoremap <leader>ly vapy<C-o>p{{jvEy}jvEpl
" Accept current autocomplete suggestion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" Faster jumping for linting errors
nnoremap [q :lprev<CR>
nnoremap ]q :lnext<CR>
nnoremap [w :cprev<CR>
nnoremap ]w :cnext<CR>
" Set breakpoint in python
noremap <leader>eb ofrom pudb import set_trace; set_trace()<ESC>
" Vertical split instead of horiztonal
noremap <c-w>f <c-w>f<c-w>L
" <c-w>] uses path not tags file? 
noremap <c-w>] <c-w>v<c-]><c-w>L
" Run isort on file
noremap <leader>ei :!isort %<CR>
" Session saving
function! SaveSession()
  :mksession! $SessionDir/session.vim
  :echo 'Session Saved!'
endfunction
nnoremap <leader>ess :call SaveSession()<CR>
nnoremap <leader>esr :source $SessionDir/session.vim<CR>
" Jump to first/last line in a paragraph
nnoremap <A-{> k{w
nnoremap <A-}> j}k^
vnoremap <A-{> k{w
vnoremap <A-}> j}k^
nnoremap <leader>y :call system('nc -w 1 172.17.0.1 41401', @0)<CR>




"-----------------------------------------------------------------------------------------------------------------------
" Ack Searching
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/ack.vim/plugin/ack.vim'))
  nnoremap <leader>/ :call AckSearch()<CR>
  noremap <leader>ea :Ack <cword><cr>
  function! AckSearch()
    call inputsave()
    let term = input('Search: ')
    call inputrestore()
    if !empty(term)
        execute "Ack! " . term
    endif
  endfunction
  " Setting better default settings
  let g:ackprg =
      \ "ack -s -H --nocolor --nogroup --column --ignore-dir=.venv/ --ignore-dir=.vimcache/ --ignore-dir=migrations/ --ignore-dir=.mypy_cache/ --ignore-file=is:tags --nojs --nocss --nosass"
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Argwrap
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-argwrap/plugin/argwrap.vim'))
	nnoremap <leader>ew :ArgWrap<CR>
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Fugitive
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-fugitive/plugin/fugitive.vim'))
  " Command for toggling git status
  function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
      bd .git/index
    else
      Gstatus
    endif
  endfunction
  command ToggleGStatus :call ToggleGStatus()
  nnoremap <leader>gs :ToggleGStatus<CR>
  nnoremap <leader>gc :Gcommit --verbose<CR>
  nnoremap <leader>gd :Gdiff<CR>
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" fzf.vim
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/fzf.vim/plugin/fzf.vim'))
  nnoremap <leader>ff :Files<CR>
  nnoremap <leader>fb :Buffers<CR>
  nnoremap <leader>ft :Tags<CR>
  nnoremap <leader>fm :Marks<CR>
  nnoremap <leader>fc :Commits<CR>
  nnoremap <leader>fg :GFiles?<CR>
  " Find Directories
  nnoremap <leader>fd :call fzf#run(fzf#wrap({'source': 'find * -type d'}))<CR>
  " Enable C-N and C-P to go backwards in history
  let g:fzf_history_dir = $HOME.'.local/share/fzf-history'
  " [Buffers] Jump to the existing window if possible
  let g:fzf_buffers_jump = 1
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Indent Guides
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-indent-guides/plugin/indent_guides.vim'))
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_exclude_filetypes =['help', 'nerdtree']
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size = 1
  au VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
  au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237
  au BufEnter *.py,*.html :IndentGuidesEnable 
  au BufLeave *.py,*.html :IndentGuidesDisable
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Taboo
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/taboo.vim/plugin/taboo.vim'))
  function! RenameTab()
    call inputsave()
    let term = input('Tabname: ')
    call inputrestore()
    if !empty(term)
      execute ":TabooRename " . term
    endif
  endfunction
  nnoremap <leader>er :call RenameTab()<CR>
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Ale
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/ale/autoload/ale.vim'))
  let g:ale_lint_on_enter = 0
  let g:ale_sign_column_always = 1
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_python_mypy_options='--ignore-missing-imports --disallow-untyped-defs'
  let g:ale_history_enabled = 0 
  highlight clear ALEErrorSign
  highlight clear ALEWarningSign
  " Change gutter color
  highlight SignColumn cterm=NONE ctermfg=0 ctermbg=None
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" RainbowParentheses
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/rainbow_parentheses.vim/plugin/rainbow_parentheses.vim'))
  au VimEnter *.py RainbowParenthesesToggle
  au Syntax *.py RainbowParenthesesLoadRound
  au Syntax *.py RainbowParenthesesLoadSquare
  au Syntax *.py RainbowParenthesesLoadBraces
  let g:rbpt_colorpairs = [
    \ ['brown',         'RoyalBlue3'],
    \ ['darkblue',    'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ['magenta',     'SeaGreen3'],
    \ ['yellow', 'SeaGreen3'],
    \ ['blue',        'DarkOrchid3'],
    \ ['gray',        'firebrick3'],
    \ ['cyan',        'DarkOrchid3'],
    \ ['darkred',     'firebrick3'],
    \ ['brown',       'RoyalBlue3'],
    \ ['gray',        'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['red',       'SeaGreen3'],
    \ ['darkcyan',    'DarkOrchid3'],
    \ ['green',       'RoyalBlue3'],
    \ ]
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Pymode
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/python-mode/plugin/pymode.vim'))
  let g:pymode_python = 'python3'
  let g:pymode_run = 1
  let g:pymode_indent = 1
  let g:pymode_motion = 1
  let g:pymode_options_colorcolumn = 0
  let g:pymode_lint = 0
  let g:pymode_rope = 0
  let g:pymode_doc = 0
  let g:pymode_breakpoint = 0
  let g:pymode_lint = 0
  let g:pymode_folding = 0
  let g:pymode_motion = 0 " Disable error when using fzf to switch files
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Ranger Intergration
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/ranger.vim/plugin/ranger.vim'))
  let g:ranger_map_keys = 0
  nnoremap <leader>m :Ranger<CR>
  nnoremap <leader>n :RangerWorkingDirectory<CR>
  let g:ranger_replace_netrw = 1 " open ranger when vim open a directory
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Jinja Highlighting
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-jinja2-syntax/indent/jinja.vim'))
  au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Markdown
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-markdown/indent/markdown.vim'))
  let g:vim_markdown_folding_disabled=1
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Terraform
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-terraform/ftplugin/terraform.vim'))
  let g:terraform_align=1
  let g:terraform_commentstring='//%s'
endif
"-----------------------------------------------------------------------------------------------------------------------

"YouCompleteMe

let g:ycm_error_symbol = '?'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_highlighting = 0

nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoTo<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>gii :YcmCompleter GoToImprecise<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gti :YcmCompleter GetTypeImprecise<CR>
nnoremap <leader>gp :YcmCompleter GetParent<CR>

"ClangFormat
let g:airline#extensions#whitespace#mixed_indent_algo = 2                                                                                                                                                 
let g:clang_format#detect_style_file = 1                                                                                                                                                                  
let g:clang_format#auto_format  = 1
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
"End of ClangFormat

" Remember info about open buffers on close                                                                                                                                                               
set viminfo^=%

set viminfo+=n/home/dusan/.viminfo

" Make sure Vim returns to the same line when you reopen a file.                                                                                                                                          
" Thanks, Amit                                                                                                                                                                                            
augroup line_return                                                                                                                                                                                       
    au!                                                                                                                                                                                                   
    au BufReadPost *                                                                                                                                                                                      
        \ if line("'\"") > 0 && line("'\"") <= line("$") |                                                                                                                                                
        \     execute 'normal! g`"zvzz' |                                                                                                                                                                 
        \ endif                                                                                                                                                                                           
augroup END



"Swithch cpp files
function! SwitchSourceHeader()
				"update!
				let file_stem=expand("%:p:r")
				if (expand("%:e") == "cpp" || expand("%:e") == "cxx")
								if filereadable(file_stem . ".hpp")
												find %:p:r.hpp
								elseif filereadable(file_stem . ".h")
												find %:p:r.h
								elseif filereadable(file_stem . ".hxx")
												find %:p:r.hxx
								endif
				else
								if filereadable(file_stem . ".cpp")
												find %:p:r.cpp
								elseif filereadable(file_stem . ".cxx")
												find %:p:r.cxx
								endif
				endif
endfunction

nmap ,s :call SwitchSourceHeader()<CR>

"go back to diff names file
nnoremap <leader>b <C-w><left>:q<CR><C-^>
nnoremap <leader>n gf :Gdiff master<CR>><C-w><left>

" Highlight Word {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" }}}
" Default Highlights {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}

" this is for matchit plugin to match c++ templates
let b:match_words='<:>'


"gundo mapping                                                                                                                                                                                            
nnoremap <F5> :GundoToggle<CR>                                                                                                                                                                            
set undofile                                                                                                                                                                                              
set undodir=/home/dusan/.vimundo/                                                                                                                                                                         
                                                                                                                                                                                                          
set noswapfile                                                                                                                                                                                            
set backup                                                                                                                                                                                                
set backupdir=/home/dusan/tmp                                                                                                                                                                             
set backupskip=/home/dusan/tmp/*                                                                                                                                                                          
set directory=/home/dusan/tmp                                                                                                                                                                             
set writebackup 
