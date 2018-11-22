"-----------------------------------------------------------------------------------------------------------------------
" Plugins
"----------------------------------------------------------------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')

Plug 'gcmt/taboo.vim' " Rename Tabs
Plug 'mileszs/ack.vim' " Use ack to grep project directory
Plug 'FooSoft/vim-argwrap' " Wrap or unwrap arguments to functions
Plug 'w0rp/ale' " Async linting
Plug 'tpope/vim-commentary' " Better commenting commands
Plug 'tpope/vim-fugitive' " Git integration with vim
Plug 'tpope/vim-surround' " Helps with surrounding text
Plug 'tpope/vim-repeat' " Enable Repeating of plugin maps

" Colorschemes
Plug 'https://github.com/rafi/awesome-vim-colorschemes.git'
Plug 'flazz/vim-colorschemes'
Plug 'micha/vim-colors-solarized'

Plug 'sjl/gundo.vim'

"This errors
"Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'morhetz/gruvbox' " Pretty colorscheme
Plug 'Valloric/YouCompleteMe' " Autocomplete
"
Plug 'rhysd/vim-clang-format'

Plug 'rbgrouleff/bclose.vim' " Ranger dep for neovim
Plug 'francoiscabrol/ranger.vim'  " Ranger integration
Plug 'nathanaelkane/vim-indent-guides' " Creates indent lines, makes code a bit easier to read
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf
Plug 'junegunn/fzf.vim' " fzf integration
Plug 'eapache/rainbow_parentheses.vim' " Colored Brackets
Plug 'saltstack/salt-vim' " Salt file plugin
Plug 'plasticboy/vim-markdown' " Markdown syntax
Plug 'reedes/vim-pencil' " Writing utility
Plug 'junegunn/goyo.vim' " Distraction Free writing
Plug 'mattn/emmet-vim' " Html expansion plugin
Plug 'majutsushi/tagbar' " Tagbar explorer
Plug 'hashivim/vim-terraform' " Terraform plugin
Plug 'godlygeek/tabular' " Formatting code

" File Type Specific
Plug 'ledger/vim-ledger' " Ledger plugin
Plug 'python-mode/python-mode' " Python awesomeness in vim
Plug 'chr4/nginx.vim' " nginx goodness

" My custom options
Plug 'thornycrackers/vim-options'

call plug#end()

" These options don't work inside vim-options
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
"-----------------------------------------------------------------------------------------------------------------------
