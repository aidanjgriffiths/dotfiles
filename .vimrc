call plug#begin('~/vim_plugins/vim-plug')
" Plugins
Plug '~/vim_plugins/vim-surround'
Plug '~/vim_plugins/ale', {'for': 'python'}

call plug#end()

let g:ale_linters={'python': ['pylint', 'bandit']}
let g:ale_fixers={'python': ['black', 'isort']}
let g:ale_fix_on_save = 1

" display all matching files with tab
set wildmenu

" show name of opened file
set laststatus=2

" easy buffer toggling with `F5`
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <F1> :%s/\s\+$//e

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

let g:NetrwIsOpen=0

" highlight whitespace in dark green
highlight ExtraWhitespace ctermbg=22
"highlight ColorColumn ctermbg=lightblue

match ExtraWhitespace /\s\+$/

" folding toggling with spacebar mapping
nnoremap <space> za
vnoremap <space> zf

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

" Ctrl+\ - Open the definition in a new tab
" Alt+] - Open the definition in a vertical split
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

let s:term_pos = {} " { bufnr: [winheight, n visible lines] }

function! EnterTerminalNormalMode()
    if &buftype != 'terminal' || mode('') != 't'
        return 0
    endif
    call feedkeys("\<LeftMouse>\<c-w>N", "x")
    let s:term_pos[bufnr()] = [winheight(winnr()), line('$') - line('w0')]
    call feedkeys("\<ScrollWheelUp>")
endfunction

function! ExitTerminalNormalModeIfBottom()
    if &buftype != 'terminal' || !(mode('') == 'n' || mode('') == 'v')
        return 0
    endif
    let term_pos = s:term_pos[bufnr()]
    let vis_lines = line('$') - line('w0')
    let vis_empty = winheight(winnr()) - vis_lines
    " if size has only expanded, match visible lines on entry
    if term_pos[1] <= winheight(winnr())
        let req_vis = min([winheight(winnr()), term_pos[1]])
        if vis_lines <= req_vis | call feedkeys("i", "x") | endif
    " if size has shrunk, match visible empty lines on entry
    else
        let req_vis_empty = term_pos[0] - term_pos[1]
        let req_vis_empty = min([winheight(winnr()), req_vis_empty])
        if vis_empty >= req_vis_empty | call feedkeys("i", "x") | endif
    endif
endfunction

" scrolling up enters normal mode in terminal window, scrolling back to
" the cursor's location upon entry resumes terminal mode. only limitation
" is that terminal window must have focus before you can scroll to
" enter normal mode
tnoremap <silent> <ScrollWheelUp> <c-w>:call EnterTerminalNormalMode()<CR>
nnoremap <silent> <ScrollWheelDown> <ScrollWheelDown>:call ExitTerminalNormalModeIfBottom()

"~/.vimrc ends here
