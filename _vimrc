" vim with all enhancements
source $vimruntime/vimrc_example.vim

" c# bracket autoclosure
autocmd filetype cs inoremap {<CR> {<CR>}<ESC>O
autocmd filetype cs inoremap {;<CR> {<CR>};<ESC>O

" misc options
set relativenumber
set number
set nowrapscan
set hidden
set ignorecase
set cursorcolumn

" from theprimeagen
set guicursor=
set noerrorbells
set noswapfile
set nobackup
set scrolloff=8
set undodir=C:\Users\\.vim\undo-dir
set undofile
set cmdheight=2
set wildmenu
set completeopt=menuone,noinsert,noselect

" Close current buffer without messing up window splits
nnoremap <C-c> :bp\|bd #<CR>

" leader mappings
let mapleader = " "

"turn off search highlighting (temporary)
nnoremap <leader>h :nohl<CR>

" Search for duplicate of current line
nnoremap <leader>* 0y$\/V<C-r>"<CR>

" Copy whole line without newline
nnoremap <leader>y 0y$

" Paste over without replacing register
vnoremap <leader>p pgvy

" resizing splits
nnoremap <Leader>+ :res +5<CR>
nnoremap <Leader>- :res -5<CR>
nnoremap <leader>> :vertical resize +5<CR>
nnoremap <leader>< :vertical resize -5<CR>

"F keys
nnoremap <F3> :bprevious
nnoremap <F4> :bnext
nnoremap <F7> gT
nnoremap <F8> gt
nnoremap <F9> :tabe<CR>
nnoremap <F12> :tabclose!<CR>

" moving lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Y yanks to end of line
nnoremap Y y$

" keep the screen centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'



" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


" initialize gruvbox
" ~\vimfiles\pack\default\start\gruvbox is folder location
"set t_Co=256
set termguicolors
set background=dark
syntax on
autocmd VimEnter * ++nested colorscheme gruvbox
