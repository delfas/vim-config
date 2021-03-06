function! RunningInsideGit()
  let result = system('env | grep ^GIT_')
  if result == ""
    return 0
  else
    return 1
  endif
endfunction

let g:jellybeans_overrides = {
\  'Cursor': { 'guibg': 'ff00ee', 'guifg': '000000' },
\  'Search': { 'guifg': '00ffff', 'attr': 'underline' },
\  'StatusLine': { 'guibg': 'ffb964', 'guifg': '000000', 'attr': 'bold' }
\}

let g:indexer_debugLogLevel = 2

" not a vi
set encoding=utf-8

" Get Vundle up and running
set nocompatible               " be iMproved
filetype off                   " required!
set runtimepath+=$HOME/vimfiles/bundle/Vundle.vim
call vundle#begin('$HOME/vimfiles/bundle/')
"
" Set the search scan to wrap around the file
Plugin 'henrik/vim-indexed-search'
"
" core plugins
"
Plugin 'flazz/vim-colorschemes'
Plugin 'tomasr/molokai'
Plugin 'kien/ctrlp.vim'
"
" vim main plugins
"
Plugin 'sjl/gundo.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'scrooloose/syntastic.git'
Plugin 'vim-scripts/tComment'
Plugin 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'edsono/vim-matchit'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-repeat'
Plugin 'jiangmiao/auto-pairs'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'godlygeek/tabular'
Plugin 'airblade/vim-gitgutter'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rhysd/clever-f.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ervandew/supertab'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-commentary'
"
" togglable panels
"
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-scripts/taglist.vim'
Plugin 'majutsushi/tagbar'
"      '
" language vundles
"
Plugin 'OrangeT/vim-csharp'
Plugin 'pangloss/vim-javascript'
Plugin 'marijnh/tern_for_vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'fatih/vim-go'
Plugin 'klen/python-mode'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-scripts/c.vim'
Plugin 'tpope/vim-fireplace'
Plugin 'hylang/vim-hy'
Plugin 'kchmck/vim-coffee-script'
Plugin 'nosami/grunt-init-csharpsolution' "scripting around building solutions
Plugin 'tpope/vim-dispatch' "starts omniserer
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'janko-m/vim-test'
"Plugin 'w0rp/ale' "run linters
"
" databases
"
Plugin 'vim-scripts/SQLUtilities'
Plugin 'NagatoPain/AutoSQLUpperCase.vim'
"
" autocomplete
"
Plugin 'Valloric/YouCompleteMe'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
"      '
" snippets
"
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'DfrankUtil'
Plugin 'GEverding/vim-hocon'
Plugin 'MarcWeber/vim-addon-completion'
Plugin 'VisIncr'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bufkill.vim'
Plugin 'clones/vim-genutils'
Plugin 'elzr/vim-json'
Plugin 'endel/vim-github-colorscheme'
Plugin 'gregsexton/gitv'
Plugin 'jceb/vim-hier'
Plugin 'laurentgoudet/vim-howdoi'
Plugin 'nanotech/jellybeans.vim'

if has("gui")
  Plugin 'nathanaelkane/vim-indent-guides'
endif
Plugin 'noahfrederick/vim-hemisu'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/TwitVim'
Plugin 'vim-scripts/gnupg.vim'
Plugin 'vim-scripts/vim-geeknote'
Plugin 'vim-scripts/vimwiki'
Plugin 'vimprj'
Plugin 'whatyouhide/vim-gotham'
Plugin 'chrisbra/csv.vim'
call vundle#end()

" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

" Tabstops are 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Printing options
set printoptions=header:0,duplex:long,paper:letter

" set the search scan to wrap lines
set wrapscan

" I'm happy to type the case of things.  I tried the ignorecase, smartcase
" thing but it just wasn't working out for me
set noignorecase

set shell=bash

" set the forward slash to be the slash of note.  Backslashes suck
set shellslash
if has("unix")
  set shell=zsh
else
  if has("linux")
    set shell=ksh.exe
  else
    if has("win32") || has("win64") || has("win16")
      " Then only inside this if block for windows, I test the shell value
      " On windows, if called from cygwin or msys, the shell needs to be changed to cmd.exe
      if &shell=~#'bash$'
        set shell=cmd shellcmdflag=/c " sets shell to correct path for cmd.exe
        set shellxescape-=\>
        set shellxescape-=\&
      endif
    endif
  endif
endif

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
set vb

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" Make sure that unsaved buffers that are to be put in the background are 
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$

function! CustomFugitiveStatusLine()
  let status = fugitive#statusline()
  let trimmed = substitute(status, '\[Git(\(.*\))\]', '\1', '')
  let trimmed = substitute(trimmed, '\(\w\)\w\+[_/]\ze', '\1/', '')
  let trimmed = substitute(trimmed, '/[^_]*\zs_.*', '', '')
  if len(trimmed) == 0
    return ""
  else
    return '(' . trimmed[0:10] . ')'
  endif
endfunction

" Set the status line the way i like it
set stl=%f\ %m\ %r%{CustomFugitiveStatusLine()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Don't update the display while executing macros
set lazyredraw

" Don't show the current command in the lower right corner.  In OSX, if this is
" set and lazyredraw is set then it's slow as molasses, so we unset this
set showcmd

set ruler

" Show the current mode
set showmode

" Switch on syntax highlighting.
syntax on


" Hide the mouse pointer while typing
set mousehide

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" set the gui options the way I like
set guioptions=acg

" Setting this below makes it sow that error messages don't disappear after one second on startup.
"set debug=msg

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=500

" Keep some stuff in the history
set history=5000

set foldlevelstart=99
" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Allow the cursor to go in to "invalid" places
set virtualedit=all

" Disable encryption (:X)
set key=

" Make the command-line completion better
set wildmenu

" Same as default except that I remove the 'u' option
set complete=.,w,b,t

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Disable it... every time I hit the limit I unset this anyway. It's annoying
set textwidth=0

" get rid of the silly characters in separators
set fillchars = ""

" Add ignorance of whitespace to diff
set diffopt=iwhite,filler,vertical

" Enable search highlighting
set hlsearch

" Incrementally match the search
set incsearch

" Add the unnamed register to the clipboard
set clipboard+=unnamed

" Automatically read a file that has changed on disk
set autoread

set grepprg=grep\ -nH\ $*

" Trying out the line numbering thing... never liked it, but that doesn't mean
" I shouldn't give it another go :)
set number
set relativenumber

" Types of files to ignore when autocompleting things
set wildignore+=*.o,*.class,*.git,*.svn

" Various characters are "wider" than normal fixed width characters, but the
" default setting of ambiwidth (single) squeezes them into "normal" width, which
" sucks.  Setting it to double makes it awesome.
set ambiwidth=single

" OK, so I'm gonna remove the VIM safety net for a while and see if kicks my ass
set nobackup
set nowritebackup
set noswapfile
set nojoinspaces

" dictionary for english words
" I don't actually use this much at all and it makes my life difficult in general
"set dictionary=$VIM/words.txt

" Let the syntax highlighting for Java files allow cpp keywords
let java_allow_cpp_keywords = 1

" System default for mappings is now the "," character
let mapleader = ","

" Wipe out all buffers
nmap <silent> ,wa :call BWipeoutAll()<cr>

" Toggle paste mode
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>

" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>
nmap <silent> ,cr :lcd <c-r>=FindCodeDirOrRoot()<cr><cr>
nmap <silent> ,md :!bash -c '(mkdir -p %:p:h)'<CR>

" Turn off that stupid highlight search
nmap <silent> ,n :nohls<CR>

" put the vim directives for my file editing settings in
nmap <silent> ,vi ovim:set ts=2 sts=2 sw=2:<CR>vim600:fdm=marker fdl=1 fdc=0:<ESC>

" The following beast is something i didn't write... it will return the 
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as 
" syntax highlighting goes.
nmap <silent> ,qq :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" set text wrapping toggles
nmap <silent> <c-/> <Plug>WimwikiIndex
nmap <silent> ,wr :set invwrap<cr>
nmap <silent> ,wW :windo set invwrap<cr>

" allow command line editing like emacs
cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <End>
cnoremap <C-P>      <Up>
cnoremap <ESC>b     <S-Left>
cnoremap <ESC><C-B> <S-Left>
cnoremap <ESC>f     <S-Right>
cnoremap <ESC><C-F> <S-Right>
cnoremap <ESC><C-H> <C-W>

" Maps to make handling windows a bit easier
"noremap <silent> ,h :wincmd h<CR>
"noremap <silent> ,j :wincmd j<CR>
"noremap <silent> ,k :wincmd k<CR>
"noremap <silent> ,l :wincmd l<CR>
"noremap <silent> ,sb :wincmd p<CR>
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> ,s8 :vertical resize 83<CR>
noremap <silent> ,cj :wincmd j<CR>:close<CR>
noremap <silent> ,ck :wincmd k<CR>:close<CR>
noremap <silent> ,ch :wincmd h<CR>:close<CR>
noremap <silent> ,cl :wincmd l<CR>:close<CR>
noremap <silent> ,cc :close<CR>
noremap <silent> ,cw :cclose<CR>
noremap <silent> ,ml <C-W>L
noremap <silent> ,mk <C-W>K
noremap <silent> ,mh <C-W>H
noremap <silent> ,mj <C-W>J
noremap <silent> <C-7> <C-W>>
noremap <silent> <C-8> <C-W>+
noremap <silent> <C-9> <C-W>+
noremap <silent> <C-0> <C-W>>

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,eV :tabnew  $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>
" nnoremap <leader>v :e  ~/.config/nvim/init.vim<CR>
" nnoremap <leader>eV :tabnew  ~/.config/nvim/init.vim<CR>

" Make horizontal scrolling easier
nmap <silent> <C-o> 10zl
nmap <silent> <C-i> 10zh

" Add a GUID to the current line
imap <C-J>d <C-r>=substitute(system("uuidgen"), '.$', '', 'g')<CR>

" Toggle fullscreen mode
nmap <silent> <F3> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

" Underline the current line with '='
nmap <silent> ,u= :t.\|s/./=/g\|:nohls<cr>
nmap <silent> ,u- :t.\|s/./-/g\|:nohls<cr>
nmap <silent> ,u~ :t.\|s/./\\~/g\|:nohls<cr>

" Shrink the current window to fit the number of lines in the buffer.  Useful
" for those buffers that are only a few lines
nmap <silent> ,sw :execute ":resize " . line('$')<cr>

" Use the bufkill plugin to eliminate a buffer but keep the window layout
nmap ,bd :BD<cr>
nmap ,bw :BW<cr>

" Use CTRL-E to replace the original ',' mapping
nnoremap <C-E> ,

" Alright... let's try this out
imap jj <esc>
cmap jj <esc>

" I like jj - Let's try something else fun
imap ,fn <c-r>=expand('%:t:r')<cr>

" Clear the text using a motion / text object and then move the character to the
" next word
nmap <silent> ,C :set opfunc=ClearText<CR>g@
vmap <silent> ,C :<C-U>call ClearText(visual(), 1)<CR>

" Make the current file executable
nmap ,x :w<cr>:!chmod 755 %<cr>:e<cr>

" Bookmark shortcuts
nnoremap <leader>bb :Bookmark<space>
nnoremap <leader>bf :BookmarkToRoot<space>

" Digraphs
" Alpha
imap <c-l><c-a> <c-k>a*
" Beta
imap <c-l><c-b> <c-k>b*
" Gamma
imap <c-l><c-g> <c-k>g*
" Delta
imap <c-l><c-d> <c-k>d*
" Epslion
imap <c-l><c-e> <c-k>e*
" Lambda
imap <c-l><c-l> <c-k>l*
" Eta
imap <c-l><c-y> <c-k>y*
" Theta
imap <c-l><c-h> <c-k>h*
" Mu
imap <c-l><c-m> <c-k>m*
" Rho
imap <c-l><c-r> <c-k>r*
" Pi
imap <c-l><c-p> <c-k>p*
" Phi
imap <c-l><c-f> <c-k>f*

function! ClearText(type, ...)
	let sel_save = &selection
	let &selection = "inclusive"
	let reg_save = @@
	if a:0 " Invoked from Visual mode, use '< and '> marks
		silent exe "normal! '<" . a:type . "'>r w"
	elseif a:type == 'line'
		silent exe "normal! '[V']r w"
	elseif a:type == 'line'
		silent exe "normal! '[V']r w"
    elseif a:type == 'block'
      silent exe "normal! `[\<C-V>`]r w"
    else
      silent exe "normal! `[v`]r w"
    endif
    let &selection = sel_save
    let @@ = reg_save
endfunction

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" I don't like it when the matching parens are automatically highlighted
let loaded_matchparen = 1

" Highlight the current line and column
" Don't do this - It makes window redraws painfully slow
set nocursorline
set nocursorcolumn

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
nnoremap <leader>so :OpenSession 
nnoremap <leader>ss :SaveSession 
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" togglables without FN keys
nnoremap <leader>1 :GundoToggle<CR>
set pastetoggle=<leader>2
nnoremap <leader>3 :TlistToggle<CR>
nnoremap <leader>4 :TagbarToggle<CR>
nnoremap <leader>5 :NERDTreeToggle<CR>

" visual reselect of just pasted
nnoremap gp `[v`]

"make enter break and do newlines
nnoremap <CR> O<Esc>j
nnoremap <leader>j i<CR><Esc>==

"make space in normal mode add space
nnoremap <Space> i<Space><Esc>l

" better scrolling
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" consistent menu navigation
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" intellij style autocomplete shortcut
inoremap <C-@> <C-x><C-o>
inoremap <C-Space> <C-x><C-o>

" ctrlP config
" let g:ctrlp_map = "<c-p>"
" nnoremap <leader>t :CtrlPMRU<CR>
" nnoremap <leader>bp :CtrlPBuffer<CR>

" easy motion rebinded
" nmap <leader>f <Plug>(easymotion-f2)
" nmap <leader>F <Plug>(easymotion-F2)


" reload all open buffers
nnoremap <leader>Ra :tabdo exec "windo e!"

"map next-previous jumps
nnoremap <leader>m <C-o>
nnoremap <leader>. <C-i>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Use sane regexes
nnoremap <leader>/ /\v
vnoremap <leader>/ /\v

" Use :Subvert search
nnoremap <leader>// :S /
vnoremap <leader>// :S /

" Use regular replace
nnoremap <leader>s :%s /
vnoremap <leader>s :%s /

" Use :Subvert replace
nnoremap <leader>S :%S /
vnoremap <leader>S :%S /

" clever-f prompt
let g:clever_f_show_prompt = 1
let g:clever_f_across_no_line = 1

" airline
if !exists("g:airline_symbols")
  let g:airline_symbols = {}
endif
let g:airline_theme="powerlineish"
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#empty_message  =  "no .git"
let g:airline#extensions#whitespace#enabled    =  0
let g:airline#extensions#syntastic#enabled     =  1
let g:airline#extensions#tabline#enabled       =  1
let g:airline#extensions#tabline#tab_nr_type   =  1 " tab number
let g:airline#extensions#tabline#fnamecollapse =  1 " /a/m/model.rb
let g:airline#extensions#hunks#non_zero_only   =  1 " git gutter

" YouCompleteMe
let g:ycm_path_to_python_interpreter = 'python'
let g:ycm_filetype_blacklist = {}
let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
let g:ycm_key_invoke_completion = "<C-j>"
let g:ycm_collect_identifiers_from_tags_files = 1

if executable("ag")
  let g:ackprg = "ag --nogroup --column"
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" reload ctags
nnoremap <leader>C :!ctags -R --fields=+l --exclude=.git --exclude=log --exclude=tmp *<CR><CR>

" git and ack stuff
let g:gitgutter_enabled = 1
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
nnoremap <leader>G mG:Git! 
nnoremap <leader>g :Git 
nnoremap <leader>A :!ag 
nnoremap <leader>a :Ag! 

if has("mac")
  let g:main_font = "Source\\ Code\\ Pro\\ Light:h11"
  let g:small_font = "Source\\ Code\\ Pro\\ Light:h2"
else
    if has("win32") || has("win64") || has("win16")
      let g:main_font = "Consolas:h11:cANSI"
      let g:small_font = "Consolas:h10:cANSI"
    else
      let g:main_font = "DejaVu\\ Sans\\ Mono\\ 9"
      let g:small_font = "DejaVu\\ Sans\\ Mono\\ 2"
    endif
endif

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif


"-----------------------------------------------------------------------------
" Vimwiki
"-----------------------------------------------------------------------------
let g:vimwiki_list = [ { 'path': '$HOME/code/stuff/vimwiki/TDC', 'path_html': '$HOME/code/stuff/vimwiki/TDC_html' } ]
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
nmap ,vw :VimwikiIndex<cr>
augroup custom_vimwiki
  au!
  au BufEnter *.wiki setlocal textwidth=100
augroup END

"-----------------------------------------------------------------------------
" Indent Guides
"-----------------------------------------------------------------------------
let g:indent_guides_color_change_percent = 3
"let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

"-----------------------------------------------------------------------------
" Fugitive
"-----------------------------------------------------------------------------
" Thanks to Drew Neil
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \  noremap <buffer> .. :edit %:h<cr> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete

nmap ,gs :Gstatus<cr>
nmap ,ge :Gedit<cr>
nmap ,gw :Gwrite<cr>
nmap ,gr :Gread<cr>

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
                   \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
                   \ '\.embed\.manifest$', '\.embed\.manifest.res$',
                   \ '\.intermediate\.manifest$', '^mt.dep$' ]

"-----------------------------------------------------------------------------
" GPG Stuff
"-----------------------------------------------------------------------------
if has("mac")
  let g:GPGExecutable = "gpg2"
  let g:GPGUseAgent = 0
endif

"-----------------------------------------------------------------------------
" AG (SilverSearcher) Settings
"-----------------------------------------------------------------------------
function! AgRoot(pattern)
  let dir = FindCodeDirOrRoot()
  execute ':Ag ' . a:pattern . ' ' . dir
endfunction

function! AgProjectRoot(pattern)
  let dir = FindCodeDirOrRoot()
  let current = expand('%:p')
  let thedir = substitute(current, '^\(' . dir . '/[^/]\+\).*', '\1', '')
  execute ':Ag ' . a:pattern . ' ' . thedir
endfunction

command! -nargs=+ AgRoot call AgRoot(<q-args>)
command! -nargs=+ AgProjectRoot call AgProjectRoot(<q-args>)

nmap ,sR :AgRoot --cs --java --js --config
nmap ,sr :AgProjectRoot --cs --java --js --config
let g:ag_prg = '$HOME/local/bin/ag' " tofix
let g:ag_results_mapping_replacements = {
\   'open_and_close': '<cr>',
\   'open': 'o',
\ }

"-----------------------------------------------------------------------------
" TwitVim settings
"-----------------------------------------------------------------------------
let twitvim_enable_perl = 1
let twitvim_browser_cmd = 'firefox'
nmap ,tw :FriendsTwitter<cr>
nmap ,tm :UserTwitter<cr>
nmap ,tM :MentionsTwitter<cr>
function! TwitVimMappings()
    nmap <buffer> U :exe ":UnfollowTwitter " . expand("<cword>")<cr>
    nmap <buffer> F :exe ":FollowTwitter " . expand("<cword>")<cr>
    nmap <buffer> 7 :BackTwitter<cr>
    nmap <buffer> 8 :ForwardTwitter<cr>
    nmap <buffer> 1 :PreviousTwitter<cr>
    nmap <buffer> 2 :NextTwitter<cr>
endfunction
augroup custom_twitvim
  au!
  au FileType twitvim call TwitVimMappings()
augroup END

"-----------------------------------------------------------------------------
" VimSokoban settings
"-----------------------------------------------------------------------------
" Sokoban stuff
let g:SokobanLevelDirectory = "/vimfiles/bundle/vim-sokoban/VimSokoban/"

"-----------------------------------------------------------------------------
" FuzzyFinder Settings
"-----------------------------------------------------------------------------
let g:fuf_splitPathMatching = 1
let g:fuf_maxMenuWidth = 110
let g:fuf_timeFormat = ''
nmap <silent> ,fv :FufFile $HOME/vimfiles/<cr>
nmap <silent> ,fc :FufMruCmd<cr>
nmap <silent> ,fm :FufMruFile<cr>

let g:CommandTMatchWindowAtTop = 1

"-----------------------------------------------------------------------------
" CtrlP Settings
"-----------------------------------------------------------------------------
function! LaunchForThisGitProject(cmd)
  let dirs = split(expand('%:p:h'), '/')
  let target = '/'
  while len(dirs) != 0
    " let d = '/' . join(dirs, '/') " Unix
    let d = join(dirs, '/') " Windows
    if isdirectory(d . '/.git')
      let target = d
      break
    else
      let dirs = dirs[:-2]
    endif
  endwhile
  if target == '/'
    echoerr "Project directory resolved to '/'"
  else
    execute ":" . a:cmd . " " . target
  endif
endfunction

let g:ctrlp_regexp = 1
let g:ctrlp_switch_buffer = 'E'
let g:ctrlp_tabpage_position = 'c'
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_root_markers = ['.project.root']
" let g:ctrlp_user_command = 'bash -c ''(find %s -type f | grep -E "\.(gradle|sbt|conf|cs|java|rb|sh|bash|py|json|js|xml)$" | grep -v -E "/build/|/quickfix|/resolution-cache|/streams|/admin/target|/classes/|/test-classes/|/sbt-0.13/|/cache/|/project/target|/project/project|/test-reports|/it-classes")'''
" let g:ctrlp_user_command = 'bash -c ''(find %s -type f | grep -v -E "\.git/|/build/|/quickfix|/resolution-cache|/streams|/admin/target|/classes/|/test-classes/|/sbt-0.13/|/cache/|/project/target|/project/project|/test-reports|/it-classes|\.jar$")'''
" let g:ctrlp_user_command = 'bash -c ''(find %s -type f | grep -v -E "\.git/|/build/|/target|/project/project|\.jar$")'''
let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

let g:ctrlp_max_depth = 30
let g:ctrlp_max_files = 0
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_open_multiple_files = '1ri'
let g:ctrlp_match_window = 'max:40'
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>'],
  \ 'PrtSelectMove("k")':   ['<c-p>'],
  \ 'PrtHistory(-1)':       ['<c-j>', '<down>'],
  \ 'PrtHistory(1)':        ['<c-i>', '<up>']
\ }
nmap ,fb :CtrlPBuffer<cr>
nmap ,ff :CtrlP .<cr>
nmap ,fF :execute ":CtrlP " . expand('%:p:h')<cr>
nmap ,fr :call LaunchForThisGitProject("CtrlP")<cr>
nmap ,fm :CtrlPMixed<cr>

"-----------------------------------------------------------------------------
" Gundo Settings
"-----------------------------------------------------------------------------
nmap <c-F5> :GundoToggle<cr>

"-----------------------------------------------------------------------------
" Conque Settings
"-----------------------------------------------------------------------------
let g:ConqueTerm_FastMode = 1
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_PromptRegex = '^-->'
let g:ConqueTerm_TERM = 'xterm'

"-----------------------------------------------------------------------------
" EasyTags
"-----------------------------------------------------------------------------
let g:home_code_dir = '/5git'
let g:easytags_async = 1
let g:easytags_auto_highlight = 0

"-----------------------------------------------------------------------------
" Branches and Tags
"-----------------------------------------------------------------------------
let g:last_known_branch = {}

function! HasGitRepo(path)
  let hasgit = 'bash -c ''(cd ' . shellescape(a:path) . '; git rev-parse --show-toplevel 2>/dev/null )'''
  let result = system(hasgit)
  if result =~# 'fatal:.*'
    return 0
  else
    return 1
  endif
endfunction

function! FindCodeDirOrRoot()
  let filedir = shellescape(expand('%:p:h'))
  if isdirectory(filedir)
    if HasGitRepo(filedir)
      let cmd = 'bash -c ''(cd ' . filedir . ' ; git rev-parse --show-toplevel 2>/dev/null )'''
      let gitdir = system(cmd)
      if strlen(gitdir) == 0
        return '/'
      else
        return gitdir[:-2] " chomp
      endif
    else
      return '/'
    endif
  else
    return '/'
  endif
endfunction

function! GetThatBranch(root)
  if a:root != '/'
    if !has_key(g:last_known_branch, a:root)
      let g:last_known_branch[a:root] = ''
    endif
    return g:last_known_branch[a:root]
  else
    return ''
  endif
endfunction

function! UpdateThatBranch(root)
  if a:root != '/'
    let g:last_known_branch[a:root] = GetThisBranch(a:root)
  endif
endfunction

function! GetThisBranch(root)
  let file = a:root . '/.current_branch'
  if filereadable(file)
    return substitute(readfile(file)[0], '/', '-', 'g')
  elseif HasGitRepo(a:root)
    return substitute(fugitive#head(), '/', '-', 'g')
  else
    throw "You're not in a git repo"
  endif
endfunction

function! ListTagFiles(thisdir, thisbranch, isGit)
  let fs = split(glob($HOME . '/.vim-tags/*-tags'), "\n")
  let ret = []
  for f in fs
    let fprime = substitute(f, '^.*/' . a:thisdir, '', '')
    if fprime !=# f
      call add(ret, f)
    elseif a:isGit && match(f, '-' . a:thisbranch . '-') != -1
      call add(ret, f)
    endif
  endfor
  return ret
endfunction

function! MaybeRunBranchSwitch()
  let root = FindCodeDirOrRoot()
  let isGit = HasGitRepo(expand('%:p:h'))
  if root != "/"
    let thisbranch = GetThisBranch(root)
    let thatbranch = GetThatBranch(root)
    if thisbranch != ''
      let codedir = substitute(root, '/', '-', 'g')[1:]
      let fs = ListTagFiles(codedir, thisbranch, isGit)
      if len(fs) != 0
        execute 'setlocal tags=' . join(fs, ",")
      endif
      if thisbranch != thatbranch
        call UpdateThatBranch(root)
        CtrlPClearCache
      endif
    endif
  endif
endfunction

function! MaybeRunMakeTags()
  let root = FindCodeDirOrRoot()
  if root != "/"
    for f in [ 'tdc', 'mbus', 'era', 'config' ]
      if isdirectory(root . "/" . f)
        call system("cd " . root . "; $HOME/bin/maketags -c " . root . "/" . f . "&")
      endif
    endfor
  endif
endfunction

augroup dw_git
  au!
  au BufEnter * call MaybeRunBranchSwitch()
  au BufWritePost *.cs,*.js,*.java,*.conf,*.config call MaybeRunMakeTags()
augroup END

command! RunBranchSwitch call MaybeRunBranchSwitch()

"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------
function! BWipeoutAll()
  let lastbuf = bufnr('$')
  let ids = sort(filter(range(1, lastbuf), 'bufexists(v:val)'))
  execute ":" . ids[0] . "," . lastbuf . "bwipeout"
  unlet lastbuf
endfunction

if !exists('g:bufferJumpList')
  let g:bufferJumpList = {}
endif

function! IndentToNextBraceInLineAbove()
  :normal 0wk
  :normal "vyf(
  let @v = substitute(@v, '.', ' ', 'g')
  :normal j"vPl
endfunction

nmap <silent> ,ii :call IndentToNextBraceInLineAbove()<cr>

function! DiffCurrentFileAgainstAnother(snipoff, replacewith)
  let currentFile = expand('%:p')
  let otherfile = substitute(currentFile, "^" . a:snipoff, a:replacewith, '')
  only
  execute "vertical diffsplit " . otherfile
endfunction

command! -nargs=+ DiffCurrent call DiffCurrentFileAgainstAnother(<f-args>)

function! RunSystemCall(systemcall)
  let output = system(a:systemcall)
  let output = substitute(output, "\n", '', 'g')
  return output
endfunction

function! HighlightAllOfWord(onoff)
  if a:onoff == 1
    :augroup highlight_all
    :au!
    :au CursorMoved * silent! exe printf('match Search /\<%s\>/', expand('<cword>'))
    :augroup END
  else
    :au! highlight_all
    match none /\<%s\>/
  endif
endfunction

:nmap ,ha :call HighlightAllOfWord(1)<cr>
:nmap ,hA :call HighlightAllOfWord(0)<cr>

function! LengthenCWD()
  let cwd = getcwd()
  if cwd == '/'
    return
  endif
  let lengthend = substitute(cwd, '/[^/]*$', '', '')
  if lengthend == ''
    let lengthend = '/'
  endif
  if cwd != lengthend
    exec ":lcd " . lengthend
  endif
endfunction

:nmap ,ld :call LengthenCWD()<cr>

function! ShortenCWD()
  let cwd = split(getcwd(), '/')
  let filedir = split(expand("%:p:h"), '/')
  let i = 0
  let newdir = ""
  while i < len(filedir)
    let newdir = newdir . "/" . filedir[i]
    if len(cwd) == i || filedir[i] != cwd[i]
      break
    endif
    let i = i + 1
  endwhile
  " exec ":lcd /" . newdir
  exec ":lcd " . newdir
endfunction

:nmap ,nd :call ShortenCWD()<cr>

function! RedirToYankRegisterF(cmd, ...)
  let cmd = a:cmd . " " . join(a:000, " ")
  redir @*>
  exe cmd
  redir END
endfunction

command! -complete=command -nargs=+ RedirToYankRegister 
      \ silent! call RedirToYankRegisterF(<f-args>)

function! ToggleMinimap()
  if exists("s:isMini") && s:isMini == 0
    let s:isMini = 1
  else
    let s:isMini = 0
  end

  if (s:isMini == 0)
    " save current visible lines
    let s:firstLine = line("w0")
    let s:lastLine = line("w$")

    " make font small
    exe "set guifont=" . g:small_font
    " highlight lines which were visible
    let s:lines = ""
    for i in range(s:firstLine, s:lastLine)
      let s:lines = s:lines . "\\%" . i . "l"

      if i < s:lastLine
        let s:lines = s:lines . "\\|"
      endif
    endfor

    exe 'match Visible /' . s:lines . '/'
    hi Visible guibg=lightblue guifg=black term=bold
    nmap <s-j> 10j
    nmap <s-k> 10k
  else
    exe "set guifont=" . g:main_font
    hi clear Visible
    nunmap <s-j>
    nunmap <s-k>
  endif
endfunction

command! ToggleMinimap call ToggleMinimap()

" I /literally/ never use this and it's pissing me off
" nnoremap <space> :ToggleMinimap<CR>

"-----------------------------------------------------------------------------
" Auto commands
"-----------------------------------------------------------------------------
augroup custom_xsd
  au!
  au BufEnter *.xsd,*.wsdl,*.xml,*.json setl tabstop=4 shiftwidth=4
augroup END

augroup Binary
  au!
  au BufReadPre   *.bin let &bin=1
  au BufReadPost  *.bin if &bin | %!xxd
  au BufReadPost  *.bin set filetype=xxd | endif
  au BufWritePre  *.bin if &bin | %!xxd -r
  au BufWritePre  *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

"-----------------------------------------------------------------------------
" Fix constant spelling mistakes
"-----------------------------------------------------------------------------

iab Acheive    Achieve
iab acheive    achieve
iab Alos       Also
iab alos       also
iab Aslo       Also
iab aslo       also
iab Becuase    Because
iab becuase    because
iab Bianries   Binaries
iab bianries   binaries
iab Bianry     Binary
iab bianry     binary
iab Charcter   Character
iab charcter   character
iab Charcters  Characters
iab charcters  characters
iab Exmaple    Example
iab exmaple    example
iab Exmaples   Examples
iab exmaples   examples
iab Fone       Phone
iab fone       phone
iab Lifecycle  Life-cycle
iab lifecycle  life-cycle
iab Lifecycles Life-cycles
iab lifecycles life-cycles
iab Seperate   Separate
iab seperate   separate
iab Seureth    Suereth
iab seureth    suereth
iab Shoudl     Should
iab shoudl     should
iab Taht       That
iab taht       that
iab Teh        The
iab teh        the

" show trailing whitespaces
set list
set listchars=tab:▸\ ,trail:¬,nbsp:.,extends:❯,precedes:❮
augroup ListChars2
    au!
    autocmd filetype go set listchars+=tab:\ \ 
    autocmd ColorScheme * hi! link SpecialKey Normal
augroup END

"-----------------------------------------------------------------------------
" Set up the window colors and size
"-----------------------------------------------------------------------------
if has("gui_running")
  exe "set guifont=" . g:main_font

  " colorscheme navajo-night
  " colorscheme candypaper
  " colorscheme 0x7A69_dark
  colorscheme molokai


  if !exists("g:vimrcloaded")
    winpos 0 0
    if !&diff
      winsize 130 120
    else
      winsize 227 120
    endif
    let g:vimrcloaded = 1
  endif
endif
:nohls


"-----------------------------------------------------------------------------
" Local system overrides
"-----------------------------------------------------------------------------
if filereadable($HOME . "/_vimrc_local")
  execute "source " . $HOME . "/_vimrc_local"
endif


