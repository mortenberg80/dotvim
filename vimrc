" Can't code without it
syntax on

" Use Vim defaults
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=2

" Show the cursor position all the time
set ruler

" Save before :make, :suspend, etc
set autowrite

" Show partial command in status line
set showcmd

" Show matching brackets
set showmatch

" We use bash
set shell=bash

" Suffixes that get lower priority when doing tab completion for filenames
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Press F<F7><F7>8 to enter paste mode (e.g. disable autoindent etc)
set pastetoggle=<F8>

" Show matches while searching
set incsearch

" Highlight searches
set hlsearch

" Case-insensitive search
set ignorecase

" We have a fast TTY
set ttyfast

" Enable UTF-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-8859-1

" Do not wrap lines automatically
"set nowrap

" Linewidth to endless
set textwidth=0

" Turn off autoindent
"set noautoindent

" Auto indent after a {
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab
filetype indent on

" Show line numbers
set number

" }}}


" {{{ Folding

" Disable folding
set nofoldenable

" Enable folding by fold markers
"set foldmethod=marker

" Autoclose folds, when moving out of them
"set foldclose=all

" Jump 5 lines when running out of the screen
"set scrolljump=5

" Indicate jump out of the screen when 3 lines before the end of the screen
"set scrolloff=3


" }}}


" {{{ Hilight settings

" Change comment color to light blue
"hi Comment ctermfg=LightBlue guifg=LightBlue

" Hilights whitespace
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" We have a dark background
"set bg=dark

" }}}


" {{{ Command mappings etc

" Automatically reload .vimrc when changed
autocmd! bufwritepost .vimrc source %

" {{{ Transparent editing of gpg encrypted files
" By Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
    au!

    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
    " We don't want a swap file, as it writes unencrypted data to disk
    autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre      *.gpg set bin
    autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost    *.gpg set nobin
    autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

    " Convert all text to encrypted text before writing
    autocmd BufWritePre,FileWritePre    *.gpg   '[,']!gpg --default-recipient-self -ae 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost    *.gpg   u
augroup END
" }}}
