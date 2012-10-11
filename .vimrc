" vimrc file.

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" General settings
set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching
set hlsearch		" highlight search
set hidden			" allow modified buffers to be hidden
set scrolloff=3		" keep 3 lines when scrolling
set number			" show line numbers

" Syntax settings
syntax on
filetype plugin indent on
au BufNewFile,BufRead *.frag,*.vert,*.fs,*.vs setf glsl
au BufNewFile,BufRead *.hs setl expandtab

" GUI settings
if has("gui_running")
	colors desert
	set guifont=Monospace\ 10
	set guioptions=aegi
endif

" Tab width
set tabstop=4
set shiftwidth=4
set expandtab

" Text width
set textwidth=100
set wrap
set autoindent

" Russian keymap
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

" Russian, english spelling
set spelllang=ru_yo,en_us

" don't jump on *
nnoremap * *N

" Append modeline after last line in buffer.
function! AppendModeline()
	let save_cursor = getpos('.')
	let append = ' vim:set ft='.&ft.' ts='.&ts.' sw='.&sw.' tw='.&tw.' '.(&et ? 'et' : 'noet').': '
	$put =''
	$put =substitute(&commentstring, '%s', append, '')
	call setpos('.', save_cursor)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" NERDTree filter
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$']

let g:protodefprotogetter="~/.vim/pullproto.pl"
nmap <C-j> :FSHere<cr>
nmap <C-k> :FSSplitAbove<cr>

" F1 - NERDTree
nmap <F1> :NERDTreeToggle<cr>
vmap <F1> <esc>:NERDTreeToggle<cr>
imap <F1> <esc>:NERDTreeToggle<cr>

" F2 - Open BufExplorer
nmap <F2> :BufExplorer<cr>
vmap <F2> <esc>:BufExplorer<cr>
imap <F2> <esc>:BufExplorer<cr>

" F3 - Previous Buffer
nmap <F3> :bp<cr>
vmap <F3> <esc>:bp<cr>i
imap <F3> <esc>:bp<cr>i

" F4 - Next Buffer
nmap <F4> :bn<cr>
vmap <F4> <esc>:bn<cr>i
imap <F4> <esc>:bn<cr>i

" C-F4 - Delete Buffer
nmap <C-F4> :bd<cr>
vmap <C-F4> <esc>:bd<cr>i
imap <C-F4> <esc>:bd<cr>i

" F5 - Build
nmap <F5> :wall<cr>:make<cr>:cw<cr>
vmap <F5> <esc><F5>
imap <F5> <esc><F5>

" F6 - Find keyword in all included files
map <F6> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<cr>

" F12 - Next Error
map <F12> :cn<cr>zz:cc<cr>

" C-F12 - TODO List
map <C-F12> :vimgrep /TODO\\|FIXME/j **/*.cpp **/*.h<cr>:cw<cr>

" Update tags (if exist) when saving file in current directory
function! s:UpdateTags()
	if filereadable('cscope.out') && has('cscope') && executable('cscope')
		if executable('./cscope.update')
			!./cscope.update
		elseif filereadable('./cscope.files')
			!cscope -b
		else
			!cscope -Rb
		endif
		cscope reset
		cscope add cscope.out
	elseif filereadable('cscope.out') && executable('ctags')
		if executable('./tags.update')
			!./tags.update
		else
			!ctags -R
		endif
	endif
endfunction
autocmd BufWritePost $PWD/* silent call s:UpdateTags()

" Include non shared configuration
if filereadable(expand("~/.vimrc_local"))
	source ~/.vimrc_local
endif

" vim:set ft=vim ts=4 sw=4 tw=80 noet: 
