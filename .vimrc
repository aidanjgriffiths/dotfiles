" display all matching files with tab
set wildmenu

" easy buffer toggling with `F5`
nnoremap <F5> :buffers<CR>:buffer<Space>

autocmd FileType python setlocal tabstop=4 shiftwidth=4 smarttab expandtab autoindent
set hidden " hides non saved file in vim buffer, look into switching between buffers

" search into subfolders
set path=.,**
" ignore all pycache binaries
setlocal wildignore=*.pyc
syntax on

" filetype detection
filetype plugin indent on

set backspace=indent,eol,start
set hls incsearch
nnoremap <CR> :noh<CR><CR>
"visual representation of vims annoying sounds when you hit the top and bottom
"lines of a file.
set visualbell
" No .swp files, important for opening multiple files in the buffer.
set noswapfile
" set row and column on status bar
set ruler
" current colorsheme
colorscheme seoul256
" set background, not sure if its working for seoul256.vim
let g:seoul256_background = 236
let g:NetrwIsOpen=0

" highlight whitespace in dark green
highlight ExtraWhitespace ctermbg=22
" ColorColoum set in seoul256
"highlight ColorColumn ctermbg=lightblue

match ExtraWhitespace /\s\+$/

" folding toggling with spacebar mapping
nnoremap <space> za
vnoremap <space> zf

" wip pylint settings
" autocmd FileType python setlocal makeprg=pylint\ --reports=n\ --output-format=parseable
" autocmd BufWritePost *.py silent make! <afile> | silent redraw!

" setting netrw settings to act like NERDtree
let g:netrw_banner = 0 " only works for the latestv im
let g:netrw_liststype = 3
let g:netrw_browse_splits = 4
let g:netrw_winsize = 25

function! OpenToRight()
  :normal v
  let g:path=expand('%:p')
  :q!
  execute 'belowright vnew' g:path
  :normal <C-l>
endfunction

function! OpenBelow()
  :normal v
  let g:path=expand('%:p')
  :q!
  execute 'belowright new' g:path
  :normal <C-l>
endfunction

function! NetrwMappings()
    noremap <buffer> <C-l> <C-w>l
    noremap <silent> <C-f> :call ToggleNetrw()
    noremap <buffer> V :call OpenToRight()
    noremap <buffer> H :call OpenBelow()
endfunction

augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call NetrwMappings()
augroup END

function! ToggleNetrw()
    if g:NetrwIsOpen
      let i = bufnr("$")
      while (i >= 1)
        if (getbufvar(i, "&filetype") == "netrw")
          silent exe "bwipeout " . i
        endif
        let i-=1
      endwhile
      let g:NetrwIsOpen=0
    else
      let g:NetrwIsOpen=1
      silent Vex
    endif
endfunction
" Close Netrw if its the only buffer window open
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif


setlocal includeexpr=PyInclude(v:fname)
" dj finds the definition of the method/function/property being searched
setlocal include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
setlocal define=^\\s*\\\\(def\\\|class\\)\\>
highlight ColorColumn ctermbg=lightgrey
function! PyInclude(fname)
  let parts = split(a:fname, ' import ')
  let l = parts[0]
  if len(parts) > 1
        let r = parts[1]
        let joined = join([l, r]. '.')
        let fp = substitute(joined, '\.', '/', 'g') . '.py'
        let found = glob(fp, 1)
        if len(found)
          return found
        endif
  return substitute(l, '\.', '/', 'g') . '.py'
endfunction

" don't load the settings if version is less than vim==7.2
if v:version < 703
    finish
endif

set colorcolumn=90
set relativenumber number

" set folding for indended code for funcs and classes
set foldmethod=indent
set foldnestmax=1
"~/.vimrc ends here
